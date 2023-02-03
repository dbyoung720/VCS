:: ��װ���빤��
@echo off
setlocal EnableDelayedExpansion
title ��װ����Դ�����������Ҫʹ�õ��Ĺ������
set CurrentCD=%~dp0

:: ���ð�װƽ̨��x86��x64
set ToolPlatform=%1

:: ����ϵͳ�������
call %CurrentCD%src\proxy.cmd
set httpAddr=%httpproxyIP%
set httpPort=%httpproxyPT%
set http_proxy=%httpAddr%:%httpPort%
set https_proxy=%httpAddr%:%httpPort%

:: ���� MSys2 ��װƽ̨
if %ToolPlatform%==x86 (
  set "MSys2Platform=mingw-w64-i686"
  set "TempPlatForm=32"
) else (
  set "MSys2Platform=mingw-w64-x86_64"
  set "TempPlatForm=64"
)

:: ���û�������
set "ScoopDir=%CurrentCD%Tools\scoop\%ToolPlatform%"
set "msys2=%ScoopDir%\apps\msys2\current"
set "Path=%ScoopDir%;%ScoopDir%\shims;%msys2%\usr\bin;%Path%"
set "SCOOP=%ScoopDir%"
@powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
@powershell -Command "$env:SCOOP='%ScoopDir%'"
@powershell -Command "[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')"

:: ��װ scoop ����
if not exist "%ScoopDir%\shims\scoop.ps1" (
  @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://get.scoop.sh'))"
  call scoop bucket add extras
  call scoop bucket add java
  call scoop bucket add versions
  call scoop bucket add nirsoft
  ) 

:: ���� scoop �������
call scoop config proxy %httpAddr%:%httpPort%
call scoop config USE_LESSMSI $true

:: ��װ scoop ���߰������԰��Լ���Ҫ�������
if %ToolPlatform%==x86 (
  set strToolsX86=aria2\7zip\vulkan\Sysinternals\oraclejdk\oraclejre8\ant\bazel\ccache\emscripten\ghostscript\inno-setup\innoextract\innounp\jom\nsis\nginx\python27\python39\postman\scons\ragel\isx\wixtoolset\cuda\octave\ispc\git\sliksvn\mercurial\ruby\pkg-config\perl\cmake\xmake\meson\curl\bison\winflexbison\ninja\swig\nasm\yasm\vswhere\llvm\doxygen\gnuplot\julia\miktex\graphviz\go\rust\rust-msvc\msys2\depends\lazarus\notepad2\notepad3\notepadplusplus\ollydbg\gimp\xnviewmp\mpc-be\vlc\mpv\sqlitespy\heidisql\currports\currprocess\deviceioview\dllexportviewer\driverview\filetypesman\injecteddll\installedcodec\ipnetinfo\myuninstaller\netbscanner\networkconnectlog\networkcounterswatch\networkopenedfiles\networktrafficview\ntfslinksview\openedfilesview\processthreadsview\regdllview\shellexview\shellmenuview\socketsniff\videocacheview\websitesniffer\webvideocap\whatinstartup\wincrashreport\..\
  :splitx86
  for /f "tokens=1,* delims=\" %%i in ("%strToolsX86%") do (
    set ToolName=%%i
    if not exist "%ScoopDir%\apps\%ToolName%" (
      echo ��װ scoop ���߰� %ToolName%
      if "%ToolName%" == "meson" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "ninja" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "oraclejdk" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "miktex" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "cuda" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "emscripten" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "msys2" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "gnuplot" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "doxygen" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "bazel" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "postman" (
        call scoop install %ToolName%
      ) else if "%ToolName%" == "Sysinternals" (
        call scoop install %ToolName%
      ) else (
        call scoop install %ToolName% -a x86
      )
    )
    set strToolsX86=%%j
  )
  if not "%strToolsX86%"=="" goto splitx86
) else (
  set strToolsX64=aria2\7zip\vulkan\Sysinternals\pandoc\oraclejdk\oraclejre8\ant\bazel\ccache\emscripten\ghostscript\inno-setup\innoextract\innounp\jom\nsis\nginx\anaconda3\python27\python39\postman\scons\ragel\isx\wixtoolset\cuda\octave\ispc\git\sliksvn\mercurial\ruby\pkg-config\perl\cmake\xmake\meson\curl\bison\winflexbison\ninja\swig\nasm\yasm\vswhere\llvm\doxygen\gnuplot\julia\miktex\graphviz\go\rust\rust-msvc\msys2\depends\wireshark\lazarus\notepad2\notepad3\notepadplusplus\obs-studio\ollydbg\gimp\xnviewmp\qbittorrent\ffmpeg-batch\mpc-be\vlc\mpv\sqlitespy\heidisql\currports\currprocess\deviceioview\dllexportviewer\driverview\filetypesman\injecteddll\installedcodec\ipnetinfo\myuninstaller\netbscanner\networkconnectlog\networkcounterswatch\networkopenedfiles\networktrafficview\ntfslinksview\openedfilesview\processthreadsview\regdllview\shellexview\shellmenuview\socketsniff\videocacheview\websitesniffer\webvideocap\whatinstartup\wincrashreport\..\
  :splitx64
  for /f "tokens=1,* delims=\" %%i in ("%strToolsX64%") do (
    set ToolName=%%i
    if not exist "%ScoopDir%\apps\%ToolName%" (
      echo ��װ scoop ���߰� %ToolName%
      call scoop install %ToolName%
    )
    set strToolsX64=%%j
  )
  if not "%strToolsX64%"=="" goto splitx64
)

:: ��װ emscripten sdk 
if not exist "%ScoopDir%\apps\emscripten\current\upstream\emscripten\system\include\emscripten\bind.h" (
	echo ��װ emscripten sdk
  CD /D "%ScoopDir%\apps\emscripten"
  call emsdk install latest
  call emsdk activate latest
)

:: ��װ Python27 ���߰�
if not exist "%ScoopDir%\apps\python27\current\scripts\pylint.exe" (
	echo ��װ Python27 ���߰�
	CD /D "%ScoopDir%\apps\python27\current\scripts"
	..\python -m pip install --upgrade pip
	pip install numpy
	pip install flake8
	pip install meson
	pip install PyYaml
	pip install pylint
)

:: ��װ Python39 ���߰�
if not exist "%ScoopDir%\apps\python39\current\scripts\pylint.exe" (
	echo ��װ Python39 ���߰�
	CD /D "%ScoopDir%\apps\python39\current\scripts"
	..\python -m pip install --upgrade pip
	pip install numpy
	pip install flake8
	pip install meson
	pip install jinja2
	pip install PyYaml
	pip install pylint
)

:: ��װ msys2 ���߰�
if not exist "%ScoopDir%\apps\msys2\current\mingw32\bin\gcc.exe" (
	echo ��װ msys2 ���߰�
	echo export http_proxy=%httpAddr%:%httpPort%>%msys2%\etc\profile.d\proxy.sh
	echo export https_proxy=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
	echo export ftp_proxy=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
	echo export HTTP_PROXY=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
	echo export HTTPS_PROXY=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
	echo export FTP_PROXY=%httpAddr%:%httpPort%>>%msys2%\etc\profile.d\proxy.sh
	echo ����mingw%TempPlatForm%.exe���Զ����� gnupg���������֮��رմ��壬�����������ʼ��װ���߰���
	echo �ۼ���Ҫ��װ���ٶ�����߰��������ĵȴ���װ��ϡ�
	call %msys2%\mingw%TempPlatForm%.exe
	pause
	bash -c "pacman --noconfirm -Syu"
	bash -c "pacman --noconfirm -Su"
	bash -c "pacman -S --noconfirm git subversion cvs mercurial doxygen swig p7zip lzip ed meson automake autoconf libtool m4 make cmake gettext gmp pkg-config findutils ruby ruby-docs yasm nasm patch perl dos2unix unzip gperf flex bison autogen python3 help2man"
	bash -c "pacman -S --noconfirm --needed base-devel msys2-devel %MSys2Platform%-toolchain"
	bash -c "pacman -S --noconfirm %MSys2Platform%-python-certifi %MSys2Platform%-meson %MSys2Platform%-yasm %MSys2Platform%-nasm %MSys2Platform%-gtk3 %MSys2Platform%-cmake %MSys2Platform%-cninja %MSys2Platform%-openh264 %MSys2Platform%-ffmpeg %MSys2Platform%-libjpeg-turbo %MSys2Platform%-lua51 %MSys2Platform%-llvm %MSys2Platform%-qt5 %MSys2Platform%-gimp %MSys2Platform%-ogre3d %MSys2Platform%-ceres-solver %MSys2Platform%-gflags %MSys2Platform%-glog %MSys2Platform%-hdf5 %MSys2Platform%-opencv %MSys2Platform%-tesseract-ocr %MSys2Platform%-vtk"
)
