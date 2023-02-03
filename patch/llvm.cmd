@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: 编译源代码  
CD /D "%SourcePath%"

CMake -S llvm -B %BuildPathX% -G "Ninja" -DLLVM_ENABLE_PROJECTS="clang" -DCMAKE_INSTALL_PREFIX=%VSSDK% %Bpara%

if %errorlevel% NEQ 0 (
  echo cmake 命令行编译失败，将用 CMAKE-GUI 打开，进行编译
  call cmake-gui.exe -S %SourcePath% -B %BuildPathX%
)

CD /D %BuildPathX%
ninja
ninja install
