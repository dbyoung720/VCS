@echo off
SETLOCAL EnableDelayedExpansion

set BuildPlatform=%1
set BuildingPathX=%2
set VSInstallSDKX=%3
set LapackSrcPath=%4
set BuildRootPath=%5

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
set "INCLUDE=%VSInstallSDKX%\include;%VSInstallSDKX%\include\libxml2;%VSInstallSDKX%\include\freetype2;%VSInstallSDKX%\include\TBB;%VSInstallSDKX%\include\harfbuzz;%VSInstallSDKX%\include\sdl2;%INCLUDE%"
set "LIB=%VSInstallSDKX%\lib;%LIB%"
set "UseEnv=True"
title ���� lapack

:: ɾ��������ʱĿ¼
if exist %BuildingPathX%\lapack\%BuildPlatform% (
	echo ɾ��������ʱĿ¼ %BuildingPathX%\lapack\%BuildPlatform%
	RD /S /Q  %BuildingPathX%\lapack\%BuildPlatform%
)

:: ���� lapack
CMake -G "Ninja" -DCMAKE_C_COMPILER=%Intelclang% -DCMAKE_Fortran_COMPILER=%Intelifort% -DBLAS++=OFF -DCBLAS=OFF -DLAPACK++=OFF -DLAPACKE=OFF -DUSE_OPTIMIZED_BLAS=OFF -DUSE_OPTIMIZED_LAPACK=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%VSInstallSDKX% -B %BuildingPathX%\lapack\%BuildPlatform% -S %LapackSrcPath%
CMake "%BuildingPathX%\lapack\%BuildPlatform%"
CMake --build "%BuildingPathX%\lapack\%BuildPlatform%" --config Release --target install

:: ���뷢������
if %errorlevel% NEQ 0 (
  echo cmake �����б���ʧ�ܣ����� CMAKE-GUI �򿪣����б���
  call cmake-gui.exe -S "%LapackSrcPath%" -B "%BuildingPathX%\lapack\%BuildPlatform%"
)
