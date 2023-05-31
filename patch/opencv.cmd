@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: 编译类型 
set LibraryType=static

:: 扩展库路径
set opencv_contribX=%DriverPath%\opencv_contrib\modules
set opencv_contribX=%opencv_contribX:\=/%

:: 设置安装路径
if %LibraryType%==static (
  set InstallSDKPath=%VSSDK%
) else (
  set InstallSDKPath=%VSSDK%\opencv
)

:: 编译目录
set opencvBuildPath=%BuildPathX%\%LibraryType%
if exist %opencvBuildPath% (
  RD /Q /S %opencvBuildPath%
)

:: 编译
CMake %Bpara% ^
 -DOPENCV_EXTRA_MODULES_PATH=%opencv_contribX% -DOPENCV_ENABLE_NONFREE=ON-DCPU_ONLY=OFF -DWITH_CUDA=ON -DVTK_USE_CUDA=ON -DWITH_JULIA=ON -DHAVE_JULIA=ON -DBUILD_opencv_world=OFF -DCMAKE_INSTALL_PREFIX=%InstallSDKPath% -Thost=%Platform1% -A %Platform2% -B "%opencvBuildPath%" -G "%BuildLanguage%" -S "%SourcePath%"
CMake %opencvBuildPath%
Call %BuildRootPath%src\vcm.cmd %BuildRootPath% %opencvBuildPath% %SourceCodeName% %Platform2%
CMake --build %opencvBuildPath% --config Release --target install
