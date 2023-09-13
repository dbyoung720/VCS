@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: 修改 VC 工程文件为 MT 编译
call %BuildRootPath%Tools\vmt.exe "%SourcePath%"

:: VC 多进程编译
echo 开始 VC 多进程编译
MSBuild.exe %SourcePath%\opencore-amr-win.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=Release;Platform=%Platform1%^
  /flp1:LogFile=%SourcePath%\zxerr.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwrn.log;Verbosity=diagnostic;warningsonly

:: 检查 VC 编译是否有错误
if %errorlevel% NEQ 0 (
  echo 编译出现错误，停止编译。用 VS2022 打开，可自行修改。
  pause
  call "%SourcePath%\opencore-amr-win.sln"
)

copy /Y "%SourcePath%\%Platform2%\Release\libopencore-amrnb.lib" "%VSSDK%\lib\libopencore-amrnb.lib"
copy /Y "%SourcePath%\%Platform2%\Release\libopencore-amrwb.lib" "%VSSDK%\lib\libopencore-amrwb.lib"
copy /Y "%SourcePath%\%Platform2%\Release\libopencore-amrnb.lib" "%VSSDK%\lib\opencore-amrnb.lib"
copy /Y "%SourcePath%\%Platform2%\Release\libopencore-amrwb.lib" "%VSSDK%\lib\opencore-amrwb.lib"

if not exist "%VSSDK%\include\opencore-amrnb" ( md "%VSSDK%\include\opencore-amrnb")
if not exist "%VSSDK%\include\opencore-amrwb" ( md "%VSSDK%\include\opencore-amrwb")

copy /Y "%SourcePath%\amrnb\interf_dec.h" "%VSSDK%\include\opencore-amrnb\interf_dec.h"
copy /Y "%SourcePath%\amrnb\interf_enc.h" "%VSSDK%\include\opencore-amrnb\interf_enc.h"
copy /Y "%SourcePath%\amrwb\dec_if.h"     "%VSSDK%\include\opencore-amrwb\dec_if.h"
copy /Y "%SourcePath%\amrwb\if_rom.h"     "%VSSDK%\include\opencore-amrwb\if_rom.h"

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo includedir=${prefix}/include>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo.>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo Name: OpenCORE AMR-NB>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo Description: Adaptive Multi-Rate speech codec library>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo Version: 0.1.5>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo Libs: -L${libdir} -lopencore-amrnb>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc
@echo Cflags: -I${includedir}>>%VSSDK%\lib\pkgconfig\opencore-amrnb.pc

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo includedir=${prefix}/include>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo.>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo Name: OpenCORE AMR-WB>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo Description: Adaptive Multi-Rate Wideband speech codec library>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo Version: 0.1.5>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo Libs: -L${libdir} -lopencore-amrwb>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
@echo Cflags: -I${includedir}>>%VSSDK%\lib\pkgconfig\opencore-amrwb.pc
