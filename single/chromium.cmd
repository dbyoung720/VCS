@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set BuildPlatform=%1
set BuildingPathX=%2
set VSInstallSDKX=%3
set ChromeSrcPath=%4
set BuildRootPath=%5
set CurrentCD=%~dp0

:: 网络代理
set proxyIP=127.0.0.1
set proxyPort=19180
set http_proxy=http://%proxyIP%:%proxyPort%
set https_proxy=http://%proxyIP%:%proxyPort%
echo [Boto]>%CurrentCD%boto.cfg
echo proxy=%proxyIP%>>%CurrentCD%boto.cfg
echo proxy_port=%proxyPort%>>%CurrentCD%boto.cfg

:: 环境变量
set NO_AUTH_BOTO_CONFIG=%CurrentCD%boto.cfg
set Path=%DriverPath%\depot_tools;%Path%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_MSVS_VERSION=2022
SET PARAMS=-property installationPath -requires Microsoft.Component.MSBuild Microsoft.VisualStudio.Component.VC.ATLMFC Microsoft.VisualStudio.Component.VC.Tools.x86.x64  -latest -prerelease -version [,17.0)
set "VS2022=vswhere.exe %PARAMS%"
FOR /f "delims=" %%A IN ('!VS2022!') DO SET "GYP_MSVS_OVERRIDE_PATH=%%A"

:: 编译临时目录
set BuildChromiumPath=%BuildingPathX%\Chromium\%BuildPlatform%
if exist %BuildChromiumPath% (
  RD /Q /S %BuildChromiumPath%
)

:: Chromium 编译
CD /D %ChromeSrcPath%
call gn gen --ide=vs --args="is_component_build=false is_debug=false" %BuildChromiumPath%
call ninja -C %BuildChromiumPath% chrome
