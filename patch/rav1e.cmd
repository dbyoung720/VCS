@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: ���� MSys2 ����Ҫʹ�õ�·��
set MSysVSSDK=%VSSDK:\=/%

:: ����
CD /D "%SourcePath%"
cargo install cargo-c --force
cargo cbuild  --release

:: ��װ
if %BuildPlatform%==x86 (
 set targetPath=%SourcePath%\target\i686-pc-windows-msvc\release
) else (
 set targetPath=%SourcePath%\target\x86_64-pc-windows-msvc\release
)
xcopy /e /y /c /i "%targetPath%\include\*.*"   "%VSSDK%\include\" 
copy /Y %targetPath%\rav1e.lib "%VSSDK%\lib\rav1e.lib"
copy /Y %targetPath%\rav1e.pc  "%VSSDK%\lib\pkgconfig\rav1e.pc"
