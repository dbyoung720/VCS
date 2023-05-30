@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

if %BuildPlatform%==x86 (
 set px=x86-win32-vs17
) else (
 set px=x86_64-win64-vs17
)

:: ±‡“Î‘¥¥˙¬Î  
CD /D "%SourcePath%"
bash -c "export PKG_CONFIG_PATH=%PKG_CONFIG_PATH%"
bash -c "./configure --enable-static --enable-static-msvcrt --disable-docs --disable-examples --disable-tools --disable-docs --target=%px% --enable-pic --as=nasm --enable-vp8-encoder --enable-vp8-decoder --disable-shared --prefix="%InvVSSDK%"" 
bash -c "make -j 8"
bash -c "make install"
