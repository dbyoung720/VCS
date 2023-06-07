@echo off
SETLOCAL EnableDelayedExpansion

set BuildPlatform=%1
set BuildPathX=%2
set VSSDK=%3
set SourcePath=%4

set ONEAPI_ROOT=F:\Green\Language\Intel\oneAPI\2022
if %BuildPlatform%==x86 (
  set ifortpath=intel64_ia32
  set PlatformX=ia32
) else (
  set ifortpath=intel64
  set PlatformX=intel64
)

set "Intelifort1=%ONEAPI_ROOT%\compiler\latest\windows\bin\%ifortpath%\ifort.exe"
set "Intelclang1=%ONEAPI_ROOT%\compiler\latest\windows\bin\%ifortpath%\icl.exe"
set "Intelifort=%Intelifort1:\=/%"
set "Intelclang=%Intelclang1:\=/%"

call %ONEAPI_ROOT%\setvars.bat %BuildPlatform% vs2022
set "INCLUDE=%VSSDK%\include;%VSSDK%\include\libxml2;%VSSDK%\include\freetype2;%VSSDK%\include\TBB;%VSSDK%\include\harfbuzz;%VSSDK%\include\sdl2;%INCLUDE%"
set "LIB=%VSSDK%\lib;%LIB%"
set "UseEnv=True"
title 编译 lapack

:: 删除编译临时目录
if exist %BuildPathX%\lapack\%BuildPlatform% (
	echo 删除编译临时目录 %BuildPathX%\lapack\%BuildPlatform%
	RD /S /Q  %BuildPathX%\lapack\%BuildPlatform%
)

:: 编译 lapack
CMake -G "Ninja" -DCMAKE_C_COMPILER=%Intelclang% -DCMAKE_Fortran_COMPILER=%Intelifort% -DBLAS++=OFF -DCBLAS=OFF -DLAPACK++=OFF -DLAPACKE=OFF -DUSE_OPTIMIZED_BLAS=OFF -DUSE_OPTIMIZED_LAPACK=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%VSSDK% -B %BuildPathX%\lapack\%BuildPlatform% -S %SourcePath%
CMake "%BuildPathX%\lapack\%BuildPlatform%"
CMake --build "%BuildPathX%\lapack\%BuildPlatform%" --config Release --target install

:: 编译发生错误
if %errorlevel% NEQ 0 (
  echo cmake 命令行编译失败，将用 CMAKE-GUI 打开，进行编译
  call cmake-gui.exe -S "%SourcePath%" -B "%BuildPathX%\lapack\%BuildPlatform%"
)
