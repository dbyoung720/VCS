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
  call %CurrentCD%src\toolsx86.cmd
) else (
  call %CurrentCD%src\toolsx64.cmd
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
