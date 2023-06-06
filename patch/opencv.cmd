@echo off
SETLOCAL EnableDelayedExpansion

set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: �������� 
set LibraryType=static
set BuildDLLGPU=1

:: ���� CPU/GPU �汾
set BuildCPUGPU=CPU
if %BuildPlatform%==x86 (
	set "USEGPU= -DCPU_ONLY=ON -DWITH_CUDA=OFF -DVTK_USE_CUDA=OFF "
	set BuildCPUGPU=CPU
) else (
	if %BuildDLLGPU%==1 (
		set "USEGPU= -DCPU_ONLY=OFF -DWITH_CUDA=ON -DVTK_USE_CUDA=ON -DCUDA_ARCH_BIN=6.0;7.0;7.5;8.0;8.6;8.9;9.0 "
		set BuildCPUGPU=GPU
	) else (
		set "USEGPU= -DCPU_ONLY=ON -DWITH_CUDA=OFF -DVTK_USE_CUDA=OFF "
		set BuildCPUGPU=CPU
	)
)

:: ���ð�װ·��
if %LibraryType%==static (
  set InstallSDKPath=%VSSDK%
) else (
  set InstallSDKPath=%VSSDK%\opencv\shared\%BuildCPUGPU%
  
	:: �ַ��������滻���޸�Ϊ���붯̬������
	set Temp01=-DBUILD_SHARED=OFF
	set Temp02=-DBUILD_SHARED=ON
	set Temp03=-DBUILD_SHARED_LIBS=OFF
	set Temp04=-DBUILD_SHARED_LIBS=ON
	set Temp05=-DBUILD_STATIC=ON
	set Temp06=-DBUILD_STATIC=OFF
	set Temp07=-DBUILD_TESTING=OFF
	set Temp08=-DBUILD_TESTING=ON
	set Temp09=-DBUILD_TESTS=OFF
	set Temp10=-DBUILD_TESTS=ON
	set Temp11=-DBUILD_EXAMPLES=OFF
	set Temp12=-DBUILD_EXAMPLES=ON
	set Dpara=''
	for /f "tokens=*" %%f in ('powershell -command "'%Bpara%' -replace '%Temp01%', '%Temp02%' -replace '%Temp03%', '%Temp04%' -replace '%Temp05%', '%Temp06%' -replace '%Temp07%', '%Temp08%' -replace '%Temp09%', '%Temp10%' -replace '%Temp11%', '%Temp12%' "') do (
		set Dpara=%%f
	)
	set Bpara=%Dpara%
)

:: ��չ��·��
set opencv_contribX=%DriverPath%\opencv_contrib\modules
CD /D "%opencv_contribX%"
git apply --ignore-space-change --ignore-whitespace -v %RootPath%patch\opencv_contrib.patch
set opencv_contribX=%opencv_contribX:\=/%

:: ����Ŀ¼
set opencvBuildPath=%BuildPathX%_%LibraryType%\%BuildCPUGPU%
if exist %opencvBuildPath% (
  RD /Q /S %opencvBuildPath%
)

:: ����
CMake %Bpara% ^
  -DOPENCV_EXTRA_MODULES_PATH=%opencv_contribX% %USEGPU% -DENABLE_CCACHE=ON -DOPENCV_ENABLE_NONFREE=ON -DWITH_VTK=OFF -DWITH_QT=OFF -DWITH_JULIA=OFF -DHAVE_JULIA=OFF -DBUILD_opencv_world=OFF -DCMAKE_INSTALL_PREFIX=%InstallSDKPath% -Thost=%Platform1% -A %Platform2% -B "%opencvBuildPath%" -G "%BuildLanguage%" -S "%SourcePath%"
CMake %opencvBuildPath%
Call %BuildRootPath%src\vcm.cmd %BuildRootPath% %opencvBuildPath% %SourceCodeName% %Platform2%
CMake --build %opencvBuildPath% --config Release --target install

:: ��չ�� opencv_contrib Դ���뻹ԭ 
if exist "%DriverPath%\opencv_contrib\.git\" (
  git clean -d -fx -f
  git checkout .
)
