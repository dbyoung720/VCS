@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

CD /D %SourcePathX%

:: 将 MSYS_MinGW-w64_GCC_1220_x86-x64.7z 下载下来，放在 MPC-BE 目录下，目录名修改为 MSYS
@echo @echo off>%SourcePathX%\environments.bat
@echo :: https://mpc-be.org/MSYS/MSYS_MinGW-w64_GCC_1220_x86-x64.7z>>%SourcePathX%\environments.bat
@echo.>>%SourcePathX%\environments.bat
@echo set MPCBE_MSYS=%SourcePathX%\MSYS>>%SourcePathX%\environments.bat
@echo set MPCBE_MINGW=%SourcePathX%\MSYS\MINGW>>%SourcePathX%\environments.bat

call update_gcc.bat
call update_revision.cmd
build %BuildPlatform% Release
