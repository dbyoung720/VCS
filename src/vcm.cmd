:: 设置 VC 多进程编译
@echo off
set RootPath=%1
set BuildTempPath=%2
set VCProjectName=%3
set VCPlatformXXX=%4

:: 修改 VC 工程文件为 MT 编译
call %RootPath%Tools\vmt.exe "%BuildTempPath%"

:: 工程文件是否存在
if not exist "%BuildTempPath%\%VCProjectName%.sln" goto bEnd

:: VC 多进程编译
MSBuild.exe "%BuildTempPath%\%VCProjectName%.sln" /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
	/target:Build /property:Configuration=Release;Platform=%VCPlatformXXX%^
	/flp1:LogFile=%BuildTempPath%\zxerr.log;Verbosity=diagnostic;errorsonly^
	/flp2:LogFile=%BuildTempPath%\zxwas.log;Verbosity=diagnostic;warningsonly

:: 检查 VC 编译是否有错误
if %errorlevel% NEQ 0 (
	echo 编译出现错误，停止编译。按任意键将用 VS2022 打开，可自行修改源码。
	pause
	call "%BuildTempPath%\%VCProjectName%.sln"
	pause
)

:bEnd
