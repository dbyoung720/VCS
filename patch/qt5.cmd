@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set CodeName=%3
set VCProjectNameX=%4

:: ����Դ����  
set LibraryType=shared

if %LibraryType%==static (
  set InstallPath=%VSSDK%
) else (
  set InstallPath=%VSSDK%\%CodeName%\%LibraryType%
)

:: �ų�Ӱ��
CD /D "%BuildRootPath%\VSSDK\2022"
rename x64 x64_bak

:: ���� pkgconfig Ŀ¼
set "TMP_CONFIG_PATH=%VSSDK%\lib\pkgconfig"
set "PKG_CONFIG_PATH=%TMP_CONFIG_PATH:\=/%"

:: �����ļ�
copy /Y "%BuildRootPath%patch\%CodeName%.conf" "%SourcePath%\qtbase\mkspecs\common\msvc-desktop.conf"

::  ����Դ��
CD /D %BuildPathX%
if exist  %LibraryType% (
  RD /Q /S %LibraryType%
)
MD    %LibraryType%
CD /D %LibraryType%

call %SourcePath%\configure -confirm-license -platform win32-msvc -opensource -mp -release -verbose -%LibraryType% -opengl desktop -nomake examples -nomake tests -skip qtwebengine -skip qtspeech --prefix=%InstallPath% 
call jom
call jom install

:: �ָ�Ŀ¼
CD /D "%BuildRootPath%\VSSDK\2022"
xcopy /e /y /c /i "x64\*.*"      "x64_bak\" 
rd /S /Q x64
rename  x64_bak x64
