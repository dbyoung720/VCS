@echo off

set RootPath=%1
set Platform=%2
set CodeName=%3
set VCProjectName=%4

:: ���ñ���ѡ�������ļ�
set "CodeConfig=%RootPath%patch\%CodeName%.ini"
set "MesonBuild=%SourcePath%\meson.build"

:: ��ʼ����
if exist %CodeConfig% goto buildini
if exist %SourcePath%\CMakelists.txt goto buildcmake
if exist %MesonBuild% goto buildmeson
goto buildother

:buildcmake
CMake %Bpara% -S "%SourcePath%" -B "%BuildPathX%" -G "%BuildLanguage%" -DCMAKE_INSTALL_PREFIX="%VSSDK%" -Thost=%Platform1% -A %Platform2%
CMake "%BuildPathX%"

if %errorlevel% NEQ 0 (
  echo cmake �����б���ʧ�ܣ����� CMAKE-GUI �򿪣����б���
  call cmake-gui.exe -S %SourcePath% -B %BuildPathX%
)

call %RootPath%src\vcm.cmd %RootPath% %BuildPathX% %VCProjectName% %Platform2%

CMake --build "%BuildPathX%" --config Release --target install

if %errorlevel% NEQ 0 (
  if exist "%BuildPathX%\%VCProjectName%.sln" (
  echo ������ִ���ֹͣ���롣�� VS2022 �򿪣��������޸ġ�
  call "%BuildPathX%\%VCProjectName%.sln"
  pause
  )
  echo ��ʼ CMake ����Ͱ�װ
  CMake --build "%BuildPathX%" --config Release --target install
)
goto bEnd

:buildgcc
if not exist "%BuildPathX%" (
  if not exist "%RootPath%VSBuild" (
    cd %RootPath%
    md VSBuild
  )
  cd %RootPath%VSBuild
  md %CodeName%
  cd %CodeName%
  md %Platform1%
)

set AddParam=
if exist %CodeConfig% (
  for /f "delims=" %%a in ('call %RootPath%src\rdini.cmd /s build /i command %CodeConfig%') do (set AddParam=%%a)
)

CD /D "%BuildPathX%"
bash -c "CC=cl %InvSourcePath%/configure %AddParam% --enable-static --prefix=%InvVSSDK%"
bash -c "make -j 16"
bash -c "make install"

if %errorlevel% NEQ 0 (
  echo msys2 ����ʧ��
  pause
)

goto bEnd

:buildother
if exist  %RootPath%patch\%CodeName%.txt (
  copy /Y %RootPath%patch\%CodeName%.txt %SourcePath%\CMakelists.txt
  goto buildcmake
)

if exist %MesonBuild% (
  goto buildmeson
) 

if exist "%SourcePath%\configure" (
  goto buildgcc
) 

echo �޷�ȷ����α��� %CodeName%����ʹ���Զ������
pause
goto bEnd

:buildini
for /f "delims=" %%a in ('call %RootPath%src\rdini.cmd /s PathX /i CMakePath %CodeConfig%') do (set mValue=%%a)
if defined mValue (
  set  CMakeFilePathX=%SourcePath%\%mValue%
  set  SourcePath=!CMakeFilePathX!
  goto buildcmake
)

if exist "%SourcePath%\configure" (
  goto buildgcc
) 

for /f "delims=" %%a in ('call %RootPath%src\rdini.cmd /s build /i command %CodeConfig%') do (set cValue=%%a)
if defined cValue (
  goto buildmeson
) 

if exist %MesonBuild% (
  goto buildmeson
)

echo �޷�ȷ����α��� %CodeName%����ʹ���Զ������
pause
goto bEnd

:buildmeson
CD /D "%BuildPathX%"
if not exist %CodeConfig% (
	meson -Dbuildtype=release -Ddefault_library=static -Ddebug=false -Db_vscrt=mt --prefix=%VSSDK% %SourcePath% %BuildPathX%
) else (
  for /f "delims=" %%a in ('call %RootPath%src\rdini.cmd /s build /i command %CodeConfig%') do (set cValue=%%a)
  if defined cValue (
    meson %cValue% --prefix=%VSSDK% %SourcePath% %BuildPathX%
  ) else (
	  meson -Dbuildtype=release -Ddefault_library=static -Ddebug=false -Db_vscrt=mt --prefix=%VSSDK% %SourcePath% %BuildPathX%
  )
)

ninja
ninja install

if %errorlevel% NEQ 0 (
  echo meson ����ʧ��
  pause
)

:bEnd

