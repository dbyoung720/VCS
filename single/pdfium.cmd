@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set BuildPlatform=%1
set BuildingPathX=%2
set VSInstallSDKX=%3
set PDFiumSrcPath=%4
set BuildRootPath=%5

:: 环境变量
set Path=%DriverPath%\depot_tools;%Path%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_MSVS_VERSION=2022
SET PARAMS=-property installationPath -requires Microsoft.Component.MSBuild Microsoft.VisualStudio.Component.VC.ATLMFC Microsoft.VisualStudio.Component.VC.Tools.x86.x64  -latest -prerelease -version [,17.0)
set "VS2022=vswhere.exe %PARAMS%"
FOR /f "delims=" %%A IN ('!VS2022!') DO SET "GYP_MSVS_OVERRIDE_PATH=%%A"

:: 是否编译 V8 Engine
set V8EngineEnable=false
if %V8EngineEnable%==true (
	set V8Path=V8
) else (
	set V8Path=NoV8
)

:: 编译为动态库还是静态库
set isDLL=false
if %isDLL%==true (
	set LibraryPath=shared
) else (
	set LibraryPath=static
)

:: PDFium 编译临时目录
set BuildPDFiumPath=%BuildingPathX%\PDFium\%BuildPlatform%\%V8Path%\%LibraryPath%

:: 创建编译临时目录
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

:: 编译参数配置
echo ++++++++++++++   开始写入配置文件    ++++++++++++++
(
	echo # 是否启用 goma 支持
	echo use_goma = false
	echo # 是否编译为 Chrome 插件
	echo clang_use_chrome_plugins = false
	echo # 是否进行编译测试
	echo pdf_is_standalone = true
	echo # 是否启用 skia 支持 
	echo pdf_use_skia = false
	echo # true 编译为 debug 版本，false 编译为 release 版本
	echo is_debug = false
	echo # true 编译为动态库，false 编译为静态库
	echo is_component_build = %isDLL%
	echo # 编译为独立的一个静态库；is_component_build 为 false 是，此选项才可用。false 编译为多个静态库，true 编译为一个静态库
	echo pdf_is_complete_lib = true
	echo # xfa 支持 
	echo pdf_enable_xfa = false
	echo # v8  支持；启用 v8 后，编译时间会增加
	echo pdf_enable_v8 = %V8EngineEnable%
	echo # cpu 架构
	echo target_cpu = "%BuildPlatform%"
	echo # true 将用 clang 进行编译，false 将用 VS2022 编译
	echo is_clang = false
	echo #  设置非嵌入式构建
	echo pdf_is_standalone = true
)>%BuildPDFiumPath%\args.gn
echo ++++++++++++++   配置文件写入完成    ++++++++++++++

:: 编译
CD /D %PDFiumSrcPath%
call gn gen --ide=vs %BuildPDFiumPath%
call %BuildRootPath%Tools\vmt '%BuildPDFiumPath%','*.ninja',' /MD',' /MT','',1,1,'ASCII'
call %BuildRootPath%Tools\vmt '%BuildPDFiumPath%'
call %BuildRootPath%Tools\vmt '%BuildPDFiumPath%','toolchain.ninja','/showIncludes','/wd4506','',0,0,'ASCII'
rem call ninja -C %BuildPDFiumPath% pdfium
rem call ninja -C %BuildPDFiumPath% pdfium_test
call ninja -C %BuildPDFiumPath% pdfium_all
