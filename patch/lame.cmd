@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

xcopy /e /y /c /i "%BuildRootPath%patch\%SourceCodeName%\*.*"   "%SourcePath%\vc_solution\" 

:: 修改 VC 工程文件为 MT 编译
call %BuildRootPath%Tools\vmt.exe "%SourcePath%"

:: VC 多进程编译
@echo 多进程编译 %SourceCodeName%
title 多进程编译 %SourceCodeName%
MSBuild.exe %SourcePath%\vc_solution\vs2019_libmp3lame.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=ReleaseSSE2;Platform=%Platform1%^
  /flp1:LogFile=%SourcePath%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: 检查 VC 编译是否有错误
if %errorlevel% NEQ 0 (
  echo 编译出现错误，停止编译。用 VS2022 打开，可自行修改。
  call "%SourcePath%\vc_solution\vs2019_libmp3lame.sln"
)

:: 安装 include、lib 文件
if not exist "%VSSDK%\include\lame" (
  cd /d "%VSSDK%\include"
  md lame
)

copy /Y "%SourcePath%\output\%Platform2%\ReleaseSSE2\libmp3lame-static.lib" "%VSSDK%\lib\libmp3lame.lib"
copy /Y "%SourcePath%\output\%Platform2%\ReleaseSSE2\libmp3lame-static.lib" "%VSSDK%\lib\mp3lame.lib"
copy /Y "%SourcePath%\include\lame.h"                                       "%VSSDK%\include\lame\lame.h"
