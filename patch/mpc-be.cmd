@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

CD /D %SourcePathX%

:: �� MSYS_MinGW-w64_GCC_1220_x86-x64.7z �������������� MPC-BE Ŀ¼�£�Ŀ¼���޸�Ϊ MSYS
@echo @echo off>%SourcePathX%\environments.bat
@echo :: https://mpc-be.org/MSYS/MSYS_MinGW-w64_GCC_1220_x86-x64.7z>>%SourcePathX%\environments.bat
@echo.>>%SourcePathX%\environments.bat
@echo set MPCBE_MSYS=%SourcePathX%\MSYS>>%SourcePathX%\environments.bat
@echo set MPCBE_MINGW=%SourcePathX%\MSYS\MINGW>>%SourcePathX%\environments.bat

call update_gcc.bat
call update_revision.cmd
build %BuildPlatform% Release
