@echo off
SETLOCAL EnableDelayedExpansion

set BuildPlatform=%1
set BuildingPathX=%2
set VSInstallSDKX=%3
set obsSourcePath=%4
set BuildRootPath=%5

if %BuildPlatform%==x86 (
  set ifortpath=intel64_ia32
) else (
  set ifortpath=intel64
)

:: ���� fortran ������
set "ONEAPI_ROOT=F:\Green\Language\Intel\oneAPI\2022"
set "Intelifort1=%ONEAPI_ROOT%\compiler\latest\windows\bin\%ifortpath%\ifort.exe"
set "Intelclang1=%ONEAPI_ROOT%\compiler\latest\windows\bin\%ifortpath%\icl.exe"
set "Intelifort=%Intelifort1:\=/%"
set "Intelclang=%Intelclang1:\=/%"

:: ���û�������
call "%ONEAPI_ROOT%\setvars.bat" %BuildPlatform% vs2022
set "INCLUDE=%VSInstallSDKX%\include;%VSInstallSDKX%\include\libxml2;%VSInstallSDKX%\include\freetype2;%VSInstallSDKX%\include\TBB;%VSInstallSDKX%\include\harfbuzz;%VSInstallSDKX%\include\sdl2;%INCLUDE%"
set "LIB=%VSInstallSDKX%\lib;%LIB%"
set "UseEnv=True"
title ���� openblas

:: ɾ��������ʱĿ¼
if exist "%BuildingPathX%\openblas\%BuildPlatform%" (
	echo ɾ��������ʱĿ¼ "%BuildingPathX%\openblas\%BuildPlatform%"
	RD /S /Q  "%BuildingPathX%\openblas\%BuildPlatform%"
)

:: �� openblas �򲹶�
CD /D "%obsSourcePath%"
git apply --ignore-space-change --ignore-whitespace -v %CurrentCD%openblas.patch

:: ���� openblas
CD /D "%BuildingPathX%\openblas\%BuildPlatform%"
CMake -G "Ninja" -DCMAKE_C_COMPILER=cl -DCMAKE_CPP_COMPILER=cl -DCMAKE_Fortran_COMPILER=%Intelifort% -DBUILD_TESTING=OFF -DBLAS++=ON -DCBLAS=ON -DLAPACK++=ON -DLAPACKE=ON -DUSE_OPTIMIZED_BLAS=ON -DUSE_OPTIMIZED_LAPACK=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%VSInstallSDKX%" -B "%BuildingPathX%\openblas\%BuildPlatform%" -S "%obsSourcePath%"
CMake "%BuildingPathX%\openblas\%BuildPlatform%"
CMake --build "%BuildingPathX%\openblas\%BuildPlatform%" --config Release --target install

:: ���뷢������
if %errorlevel% NEQ 0 (
  echo cmake �����б���ʧ�ܣ����� CMAKE-GUI �򿪣����б���
  call cmake-gui.exe -S "%obsSourcePath%" -B "%BuildingPathX%\openblas\%BuildPlatform%"
)

:: Դ���뻹ԭ
cd /D "%obsSourcePath%"
git clean -d -fx -f
git checkout .

pause
