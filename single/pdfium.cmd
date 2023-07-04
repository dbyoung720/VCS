@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set BuildPlatform=%1
set BuildingPathX=%2
set VSInstallSDKX=%3
set PDFiumSrcPath=%4
set BuildRootPath=%5

:: ��������
set Path=%DriverPath%\depot_tools;%Path%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_MSVS_VERSION=2022
SET PARAMS=-property installationPath -requires Microsoft.Component.MSBuild Microsoft.VisualStudio.Component.VC.ATLMFC Microsoft.VisualStudio.Component.VC.Tools.x86.x64  -latest -prerelease -version [,17.0)
set "VS2022=vswhere.exe %PARAMS%"
FOR /f "delims=" %%A IN ('!VS2022!') DO SET "GYP_MSVS_OVERRIDE_PATH=%%A"

:: �Ƿ���� V8 Engine
set V8EngineEnable=false
if %V8EngineEnable%==true (
	set V8Path=V8
) else (
	set V8Path=NoV8
)

:: ����Ϊ��̬�⻹�Ǿ�̬��
set isDLL=false
if %isDLL%==true (
	set LibraryPath=shared
) else (
	set LibraryPath=static
)

:: PDFium ������ʱĿ¼
set BuildPDFiumPath=%BuildingPathX%\PDFium\%BuildPlatform%\%V8Path%\%LibraryPath%

:: ����������ʱĿ¼
if exist %BuildPDFiumPath% (
  RD /Q /S %BuildPDFiumPath%
)

if not exist "%BuildingPathX%\PDFium" (
	CD /D "%BuildingPathX%"
  md PDFium
)

if not exist "%BuildingPathX%\PDFium\%BuildPlatform%" (
	CD /D "%BuildingPathX%\PDFium"
  md %BuildPlatform%
)

if not exist "%BuildingPathX%\PDFium\%BuildPlatform%\%V8Path%" (
	CD /D "%BuildingPathX%\PDFium\%BuildPlatform%"
  md %V8Path%
)

if not exist "%BuildingPathX%\PDFium\%BuildPlatform%\%V8Path%\%LibraryPath%" (
	CD /D "%BuildingPathX%\PDFium\%BuildPlatform%\%V8Path%"
  md %LibraryPath%
)

:: �����������
echo ++++++++++++++   ��ʼд�������ļ�    ++++++++++++++
(
	echo # �Ƿ����� goma ֧��
	echo use_goma = false
	echo # �Ƿ����Ϊ Chrome ���
	echo clang_use_chrome_plugins = false
	echo # �Ƿ���б������
	echo pdf_is_standalone = true
	echo # �Ƿ����� skia ֧�� 
	echo pdf_use_skia = false
	echo # true ����Ϊ debug �汾��false ����Ϊ release �汾
	echo is_debug = false
	echo # true ����Ϊ��̬�⣬false ����Ϊ��̬��
	echo is_component_build = %isDLL%
	echo # ����Ϊ������һ����̬�⣻is_component_build Ϊ false �ǣ���ѡ��ſ��á�false ����Ϊ�����̬�⣬true ����Ϊһ����̬��
	echo pdf_is_complete_lib = true
	echo # xfa ֧�� 
	echo pdf_enable_xfa = false
	echo # v8  ֧�֣����� v8 �󣬱���ʱ�������
	echo pdf_enable_v8 = %V8EngineEnable%
	echo # cpu �ܹ�
	echo target_cpu = "%BuildPlatform%"
	echo # true ���� clang ���б��룬false ���� VS2022 ����
	echo is_clang = false
	echo #  ���÷�Ƕ��ʽ����
	echo pdf_is_standalone = true
)>%BuildPDFiumPath%\args.gn
echo ++++++++++++++   �����ļ�д�����    ++++++++++++++

:: ����
CD /D %PDFiumSrcPath%
call gn gen --ide=vs %BuildPDFiumPath%
call %BuildRootPath%Tools\vmt '%BuildPDFiumPath%','*.ninja',' /MD',' /MT','',1,1,'ASCII'
call %BuildRootPath%Tools\vmt '%BuildPDFiumPath%'
call %BuildRootPath%Tools\vmt '%BuildPDFiumPath%','toolchain.ninja','/showIncludes','/wd4506','',0,0,'ASCII'
rem call ninja -C %BuildPDFiumPath% pdfium
rem call ninja -C %BuildPDFiumPath% pdfium_test
call ninja -C %BuildPDFiumPath% pdfium_all
