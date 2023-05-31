@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: �������� 
set LibraryType=static

:: ��չ��·��
set opencv_contribX=%DriverPath%\opencv_contrib\modules
set opencv_contribX=%opencv_contribX:\=/%

:: ���ð�װ·��
if %LibraryType%==static (
  set InstallSDKPath=%VSSDK%
) else (
  set InstallSDKPath=%VSSDK%\opencv
)

:: ����Ŀ¼
set opencvBuildPath=%BuildPathX%\%LibraryType%
if exist %opencvBuildPath% (
  RD /Q /S %opencvBuildPath%
)

:: ����
CMake %Bpara% ^
 -DOPENCV_EXTRA_MODULES_PATH=%opencv_contribX% -DOPENCV_ENABLE_NONFREE=ON-DCPU_ONLY=OFF -DWITH_CUDA=ON -DVTK_USE_CUDA=ON -DWITH_JULIA=ON -DHAVE_JULIA=ON -DBUILD_opencv_world=OFF -DCMAKE_INSTALL_PREFIX=%InstallSDKPath% -Thost=%Platform1% -A %Platform2% -B "%opencvBuildPath%" -G "%BuildLanguage%" -S "%SourcePath%"
CMake %opencvBuildPath%
Call %BuildRootPath%src\vcm.cmd %BuildRootPath% %opencvBuildPath% %SourceCodeName% %Platform2%
CMake --build %opencvBuildPath% --config Release --target install
