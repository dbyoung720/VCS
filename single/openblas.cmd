@echo off
SETLOCAL EnableDelayedExpansion

set BuildPlatform=%1
set BuildPathX=%2
set VSSDK=%3
set SourcePath=%4
set CurrentCD=%~dp0

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
set "INCLUDE=%VSSDK%\include;%VSSDK%\include\libxml2;%VSSDK%\include\freetype2;%VSSDK%\include\TBB;%VSSDK%\include\harfbuzz;%VSSDK%\include\sdl2;%INCLUDE%"
set "LIB=%VSSDK%\lib;%LIB%"
set "UseEnv=True"
title ���� openblas

:: ɾ��������ʱĿ¼
if exist "%BuildPathX%\openblas\%BuildPlatform%" (
	echo ɾ��������ʱĿ¼ "%BuildPathX%\openblas\%BuildPlatform%"
	RD /S /Q  "%BuildPathX%\openblas\%BuildPlatform%"
)

:: �� openblas �򲹶�
CD /D "%SourcePath%"
git apply --ignore-space-change --ignore-whitespace -v %CurrentCD%openblas.patch

:: ���� openblas
CD /D "%BuildPathX%\openblas\%BuildPlatform%"
CMake -G "Ninja" -DCMAKE_C_COMPILER=cl -DCMAKE_CPP_COMPILER=cl -DCMAKE_Fortran_COMPILER=%Intelifort% -DBUILD_TESTING=OFF -DBLAS++=ON -DCBLAS=ON -DLAPACK++=ON -DLAPACKE=ON -DUSE_OPTIMIZED_BLAS=ON -DUSE_OPTIMIZED_LAPACK=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%VSSDK%" -B "%BuildPathX%\openblas\%BuildPlatform%" -S "%SourcePath%"
CMake "%BuildPathX%\openblas\%BuildPlatform%"
CMake --build "%BuildPathX%\openblas\%BuildPlatform%" --config Release --target install

:: ���뷢������
if %errorlevel% NEQ 0 (
  echo cmake �����б���ʧ�ܣ����� CMAKE-GUI �򿪣����б���
  call cmake-gui.exe -S "%SourcePath%" -B "%BuildPathX%\openblas\%BuildPlatform%"
)

:: Դ���뻹ԭ
cd /D "%SourcePath%"
git clean -d -fx -f
git checkout .

pause
