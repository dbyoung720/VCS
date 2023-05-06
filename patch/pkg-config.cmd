@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

set VCSDKLIBPATH=%WindowsSdkDir%lib\%WindowsSDKLibVersion%um\%Platform1%
set VCSDKLIBPATH=%VCSDKLIBPATH:\=/%

:: ±‡“Î‘¥¥˙¬Î  
CD /D "%SourcePath%"
bash -c "export PKG_CONFIG_PATH=%PKG_CONFIG_PATH%"
bash -c "sh ./autogen.sh"
bash -c "CC=cl.exe ./configure --disable-shared --enable-static --build=%PlatformMSys2% -L%VCSDKLIBPATH% -L%InvVSSDK%/lib --host=%PlatformMSys2% --prefix="%InvVSSDK%"" 
bash -c "make -j 8"
bash -c "make install"

if %errorlevel% NEQ 0 (
  echo msys2 ±‡“Î ß∞‹
  pause
)
