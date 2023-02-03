@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: 修改 VC 工程文件为 MT 编译
call %BuildRootPath%Tools\vmt.exe "%SourcePath%"

:: VC 多进程编译
echo 开始 VC 多进程编译
MSBuild.exe %SourcePath%\win32\VS2010\libtheora_static.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=Release;Platform=%Platform1%^
  /flp1:LogFile=%SourcePath%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: 检查 VC 编译是否有错误
if %errorlevel% NEQ 0 (
  echo 编译出现错误，停止编译。用 VS2022 打开，可自行修改。
  call "%SourcePath%\win32\VS2010\libtheora_static.sln"
)

:: 安装 include、lib 文件
copy /Y "%SourcePath%\win32\VS2010\%Platform2%\Release\libtheora_static.lib" "%VSSDK%\lib\libtheora.lib"
copy /Y "%SourcePath%\win32\VS2010\%Platform2%\Release\libtheora_static.lib" "%VSSDK%\lib\theoraenc.lib"
copy /Y "%SourcePath%\win32\VS2010\%Platform2%\Release\libtheora_static.lib" "%VSSDK%\lib\theoradec.lib"
xcopy /e /y /c /i "%SourcePath%\include\theora\*.h" "%VSSDK%\include\theora\"

