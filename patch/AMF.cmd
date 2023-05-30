@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: 修改 VC 工程文件为 MT 编译
call %BuildRootPath%Tools\vmt.exe "%SourcePath%"

:: VC 多进程编译
echo 开始 VC 多进程编译
MSBuild.exe %SourcePath%\amf\public\proj\vs2019\AmfMediaChromaKeyCommon.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=Release;Platform=%Platform1%^
  /flp1:LogFile=%SourcePath%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: 检查 VC 编译是否有错误
if %errorlevel% NEQ 0 (
  echo 编译出现错误，停止编译。用 VS2022 打开，可自行修改。
  call "%SourcePath%\amf\public\proj\vs2019\AmfMediaChromaKeyCommon.sln"
  pause
)

:: 安装 include、lib 文件
if %BuildPlatform%==x86 (
	copy /Y "%SourcePath%\amf\bin\vs2017x32Release\AmfMediaChromaKeyCommon.lib" "%VSSDK%\lib\AmfMediaChromaKeyCommon.lib"
	copy /Y "%SourcePath%\amf\bin\vs2017x32Release\AmfMediaCommon.lib"          "%VSSDK%\lib\AmfMediaCommon.lib"
	xcopy /e /y /c /i "%SourcePath%\amf\public\include\*.*" "%VSSDK%\include\amf\"
) else (
	copy /Y "%SourcePath%\amf\bin\vs2017x64Release\AmfMediaChromaKeyCommon.lib" "%VSSDK%\lib\AmfMediaChromaKeyCommon.lib"
	copy /Y "%SourcePath%\amf\bin\vs2017x64Release\AmfMediaCommon.lib"          "%VSSDK%\lib\AmfMediaCommon.lib"
	xcopy /e /y /c /i "%SourcePath%\amf\public\include\*.*" "%VSSDK%\include\amf\"
)
