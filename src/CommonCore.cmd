@echo off

set RootPath=%1
set Platform=%2
set CodeName=%3
set VCProjectName=%4

:: 设置编译选项配置文件
set "CodeConfig=%RootPath%patch\%CodeName%.ini"
set "MesonBuild=%SourcePath%\meson.build"

:: 开始编译
if exist %CodeConfig% goto buildini
if exist %SourcePath%\CMakelists.txt goto buildcmake
if exist %MesonBuild% goto buildmeson
goto buildother

:buildcmake
CMake %Bpara% -S "%SourcePath%" -B "%BuildPathX%" -G "%BuildLanguage%" -DCMAKE_INSTALL_PREFIX="%VSSDK%" -Thost=%Platform1% -A %Platform2%
CMake "%BuildPathX%"

if %errorlevel% NEQ 0 (
  echo cmake 命令行编译失败，将用 CMAKE-GUI 打开，进行编译
  call cmake-gui.exe -S %SourcePath% -B %BuildPathX%
)

call %RootPath%src\vcm.cmd %RootPath% %BuildPathX% %VCProjectName% %Platform2%

CMake --build "%BuildPathX%" --config Release --target install

if %errorlevel% NEQ 0 (
  if exist "%BuildPathX%\%VCProjectName%.sln" (
  echo 编译出现错误，停止编译。用 VS2022 打开，可自行修改。
  call "%BuildPathX%\%VCProjectName%.sln"
  pause
  )
  echo 开始 CMake 编译和安装
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
  echo msys2 编译失败
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

echo 无法确定如何编译 %CodeName%，请使用自定义编译
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

echo 无法确定如何编译 %CodeName%，请使用自定义编译
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
  echo meson 编译失败
  pause
)

:bEnd

