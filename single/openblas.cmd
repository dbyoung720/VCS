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

:: 设置 fortran 编译器
set "ONEAPI_ROOT=F:\Green\Language\Intel\oneAPI\2022"
set "Intelifort1=%ONEAPI_ROOT%\compiler\latest\windows\bin\%ifortpath%\ifort.exe"
set "Intelclang1=%ONEAPI_ROOT%\compiler\latest\windows\bin\%ifortpath%\icl.exe"
set "Intelifort=%Intelifort1:\=/%"
set "Intelclang=%Intelclang1:\=/%"

:: 设置环境变量
call "%ONEAPI_ROOT%\setvars.bat" %BuildPlatform% vs2022
set "INCLUDE=%VSInstallSDKX%\include;%VSInstallSDKX%\include\libxml2;%VSInstallSDKX%\include\freetype2;%VSInstallSDKX%\include\TBB;%VSInstallSDKX%\include\harfbuzz;%VSInstallSDKX%\include\sdl2;%INCLUDE%"
set "LIB=%VSInstallSDKX%\lib;%LIB%"
set "UseEnv=True"
title 编译 openblas

:: 删除编译临时目录
if exist "%BuildingPathX%\openblas\%BuildPlatform%" (
	echo 删除编译临时目录 "%BuildingPathX%\openblas\%BuildPlatform%"
	RD /S /Q  "%BuildingPathX%\openblas\%BuildPlatform%"
)

:: 给 openblas 打补丁
CD /D "%obsSourcePath%"
git apply --ignore-space-change --ignore-whitespace -v %CurrentCD%openblas.patch

:: 编译 openblas
CD /D "%BuildingPathX%\openblas\%BuildPlatform%"
CMake -G "Ninja" -DCMAKE_C_COMPILER=cl -DCMAKE_CPP_COMPILER=cl -DCMAKE_Fortran_COMPILER=%Intelifort% -DBUILD_TESTING=OFF -DBLAS++=ON -DCBLAS=ON -DLAPACK++=ON -DLAPACKE=ON -DUSE_OPTIMIZED_BLAS=ON -DUSE_OPTIMIZED_LAPACK=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%VSInstallSDKX%" -B "%BuildingPathX%\openblas\%BuildPlatform%" -S "%obsSourcePath%"
CMake "%BuildingPathX%\openblas\%BuildPlatform%"
CMake --build "%BuildingPathX%\openblas\%BuildPlatform%" --config Release --target install

:: 编译发生错误
if %errorlevel% NEQ 0 (
  echo cmake 命令行编译失败，将用 CMAKE-GUI 打开，进行编译
  call cmake-gui.exe -S "%obsSourcePath%" -B "%BuildingPathX%\openblas\%BuildPlatform%"
)

:: 源代码还原
cd /D "%obsSourcePath%"
git clean -d -fx -f
git checkout .

pause
