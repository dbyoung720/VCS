:: ���û������� 
@echo off

set RootPath=%1
set Platform=%2
set CodeName=%3

:: ����ϵͳ�������
call %RootPath%src\proxy.cmd
set httpAddr=%httpproxyIP%
set httpPort=%httpproxyPT%
set http_proxy=%httpAddr%:%httpPort%
set https_proxy=%httpAddr%:%httpPort%

:: scoop ���·��
set ScoopDir=%RootPath%Tools\scoop\%Platform%

:: �������·��
set MSYS2_PATH_TYPE=inherit
set JAVA_HOME=%ScoopDir%\apps\oraclejdk\current
set ANT_HOME=%ScoopDir%\apps\ant\current
set ANT_DIR=%ScoopDir%\apps\ant\current
set ANT_EXECUTABLE=%ScoopDir%\apps\ant\current\bin\ant.bat
set CUDA_PATH=%ScoopDir%\apps\cuda\current
set CUDA_BIN_PATH=%ScoopDir%\apps\cuda\current\bin
set CUDA_INC_PATH=%ScoopDir%\apps\cuda\current\include
set CUDA_LIB_PATH=%ScoopDir%\apps\cuda\current\lib
set VULKAN_SDK=%ScoopDir%\apps\Vulkan\current
set VK_SDK_PATH=%ScoopDir%\apps\Vulkan\current
set PYTHON2_EXECUTABLE=%ScoopDir%\apps\python27\current\Python.exe
set PYTHON3_EXECUTABLE=%ScoopDir%\apps\python39\current\Python.exe
set EMSCRIPTEN_ROOT=%ScoopDir%\apps\emscripten\current
set Julia_EXECUTABLE=%ScoopDir%\apps\julia\current\bin\julia.exe

:: Դ�����Ƿ����
set "CodeConfig=%RootPath%patch\%CodeName%.ini"
if exist %CodeConfig% (
	for /f "delims=" %%a in ('call %RootPath%src\rdini.cmd /s PathX /i SourcePath %CodeConfig%') do (set cValue=%%a)
	if defined cValue (
    set SourceFilePath=%DriverPath%\!cValue!
    if exist !SourceFilePath! (set SourcePath=!SourceFilePath!&&goto CCT)
	) else (
	  set SourcePath=%DriverPath%\%CodeName%
	  if exist %SourcePath% (goto CCT)
	)
	
	echo !SourcePath! Դ���벻���ڣ�������Դ�룬�ŵ���Ŀ¼��
	pause
)
if exist %SourcePath% (goto CCT)
echo %SourcePath% Դ���벻���ڣ�������Դ�룬�ŵ���Ŀ¼��
pause

:CCT
:: ���� CMake ����Ĭ�ϲ���
set "sFile=%RootPath%src\cmake.txt"
set "sPara="
for /f "tokens=*" %%I in (%sFile%) do (set "sPara=!sPara! %%I")
set "Bpara=%sPara% %Bpara%"

set VRD=%RootPath%patch\vulkan\registry
set VRD=%VRD:\=/%

set PYTHONEXE=%ScoopDir%\apps\python39\current\Python.exe
set PYTHONEXE=%PYTHONEXE:\=/%

set "Bpara=-DPYTHON_EXECUTABLE=%PYTHONEXE% -DVulkanRegistry_DIR=%VRD% %Bpara%"

:: ������ʱ����·��
set "BuildPathX=%RootPath%VSBuild\%CodeName%\%Platform%"
if exist %BuildPathX% (
  cd /d %RootPath%VSBuild\%CodeName%
  RD /Q /S %Platform%
)
if not exist "%RootPath%VSBuild" (
    cd /d %RootPath%
    md VSBuild
)
if not exist "%RootPath%VSBuild\%CodeName%" (
  cd /d %RootPath%VSBuild
  md %CodeName%
)
if not exist "%RootPath%VSBuild\%CodeName%\%Platform%" (
  cd /d %RootPath%VSBuild\%CodeName%
  md %Platform%
)

:: VSSDK ��װ·��
set "VSSDK=%RootPath%VSSDK\2022\%Platform%"
set "InvVSSDK=/%VSSDK:\=/%"
set "LogicDSK=%InvVSSDK:~,2%"
set "AbsolDir=%InvVSSDK:~3%"
set "InvVSSDK=%LogicDSK%%AbsolDir%"

:: ���� PKG_CONFIG_PATH ��������
set PKGCONFIGPATH__=%VSSDK%\lib\pkgconfig
set PKG_CONFIG_PATH=/%PKGCONFIGPATH__:\=/%
set LogicDSK=%PKG_CONFIG_PATH:~,2%
set AbsolDir=%PKG_CONFIG_PATH:~3%
set PKG_CONFIG_PATH=%LogicDSK%%AbsolDir%

:: ����ϵͳ����·��
if %CodeName%==glib       goto Env02
if %CodeName%==cairo      goto Env02
if %CodeName%==QT5        goto Env02
if %CodeName%==llvm       goto Env02
if %CodeName%==fontconfig goto Env02
if %CodeName%==openh264   goto Env02
if %CodeName%==dav1d      goto Env02
if %CodeName%==fribidi    goto Env02
:Env01
set "Path=%USERPROFILE%\.cargo\bin;%PKGCONFIGPATH__%;%RootPath%Tools;%VSSDK%\bin;%ScoopDir%;%ScoopDir%\apps\shims;%ScoopDir%\apps\python39\current;%ScoopDir%\apps\python27\current;%ScoopDir%\apps\cmake\current\bin;%ScoopDir%\apps\nsis\current;%ScoopDir%\apps\rust-msvc\current\bin;%ScoopDir%\apps\msys2\current;%ScoopDir%\apps\msys2\current\usr\bin;%Path%;"
:Env02
set Path=%RootPath%Tools;%ScoopDir%\apps\nsis\current;%VSSDK%\bin;%Path%;

:: VS2022 ����
set "BuildLanguage=Visual Studio 17 2022"

:: ��������
if %Platform%==x86 (
  set Platform1=x86
  set Platform2=Win32
  set Platform3=32
  set Platform4=x86
  set Platform5=VC-WIN32
  set PlatformMSys2=i686-w64-mingw32
) else (
  set Platform1=x64
  set Platform2=x64
  set Platform3=64
  set Platform4=amd64
  set Platform5=VC-WIN64A
  set PlatformMSys2=x86_64-w64-mingw32
)

:: VS2022 ������������
SET "PARAMS=-property installationPath -requires Microsoft.Component.MSBuild Microsoft.VisualStudio.Component.VC.ATLMFC Microsoft.VisualStudio.Component.VC.Tools.x86.x64  -latest -prerelease -version [,17.0)"
set "VS2022=vswhere.exe %PARAMS%"
FOR /f "delims=" %%A IN ('!VS2022!') DO SET "VCVARS=%%A\Common7\Tools\vsdevcmd.bat"
CALL "%VCVARS%" -no_logo -arch=%Platform4%
set "INCLUDE=%VSSDK%\include;%VSSDK%\include\libxml2;%VSSDK%\include\freetype2;%VSSDK%\include\TBB;%VSSDK%\include\harfbuzz;%VSSDK%\QT5;%VSSDK%\include\sdl2;%CUDA_INC_PATH%;%VULKAN_SDK%\include;%INCLUDE%"
set "LIB=%VSSDK%\lib;%CUDA_LIB_PATH%\%Platform2%;%VULKAN_SDK%\lib;%VCToolsInstallDir%atlmfc\lib\%Platform1%;%LIB%"
set "UseEnv=True"

:: ��������������SDK��������
call %RootPath%src\sdk.cmd
