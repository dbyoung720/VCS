@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: ±àÒë
CD /D %BuildPathX%
set CL=/MP
%ScoopDir%\apps\perl\current\perl\bin\perl %SourcePath%\Configure %Platform5% no-shared --prefix="%VSSDK%"
nmake
nmake install

:: ¼ì²é VC ±àÒëÊÇ·ñÓÐ´íÎó
if %ERRORLEVEL% NEQ 0 (
  echo ±àÒë³öÏÖ´íÎó£¬Í£Ö¹±àÒë
  pause
)

copy /Y "%VSSDK%\lib\libssl.lib"    "%VSSDK%\lib\ssl.lib"
copy /Y "%VSSDK%\lib\libcrypto.lib" "%VSSDK%\lib\crypto.lib"

:: °²×° PC ÎÄ¼þ
set "InstallPCPath=%VSSDK:\=/%"

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\openssl.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo includedir=${prefix}/include>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo Name: OpenSSL>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo Description: Secure Sockets Layer and cryptography libraries and tools>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo Version: 1.1.1n>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo Requires: libssl libcrypto>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo Libs: -L${libdir} -llibssl -lcrypto -lws2_32 -lgdi32 -lcrypt32 -lUser32 -lAdvapi32>>%VSSDK%\lib\pkgconfig\openssl.pc
@echo Cflags: -I${includedir}>>%VSSDK%\lib\pkgconfig\openssl.pc

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\libssl.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo includedir=${prefix}/include>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo Name: OpenSSL-libssl>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo Description: Secure Sockets Layer and cryptography libraries>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo Version: 1.1.1n>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo Requires.private: libcrypto>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo Libs: -L${libdir} -llibssl -lws2_32 -ladvapi32 -lcrypt32 -luser32>>%VSSDK%\lib\pkgconfig\libssl.pc
@echo Cflags: -I${includedir}>>%VSSDK%\lib\pkgconfig\libssl.pc

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo includedir=${prefix}/include>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo enginesdir=${libdir}/engines-1_1>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo Name: OpenSSL-libcrypto>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo Description: OpenSSL cryptography library>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo Version: 1.1.1n>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo Libs: -L${libdir} -lcrypto -lws2_32 -lgdi32 -lcrypt32 -ladvapi32>>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo Libs.private: -lws2_32 -lgdi32 -lcrypt32 >>%VSSDK%\lib\pkgconfig\libcrypto.pc
@echo Cflags: -I${includedir}>>%VSSDK%\lib\pkgconfig\libcrypto.pc
