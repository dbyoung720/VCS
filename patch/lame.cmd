@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

xcopy /e /y /c /i "%BuildRootPath%patch\%SourceCodeName%\*.*"   "%SourcePath%\vc_solution\" 

:: �޸� VC �����ļ�Ϊ MT ����
call %BuildRootPath%Tools\vmt.exe "%SourcePath%"

:: VC ����̱���
@echo ����̱��� %SourceCodeName%
title ����̱��� %SourceCodeName%
MSBuild.exe %SourcePath%\vc_solution\vs2019_libmp3lame.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=ReleaseSSE2;Platform=%Platform1%^
  /flp1:LogFile=%SourcePath%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: ��� VC �����Ƿ��д���
if %errorlevel% NEQ 0 (
  echo ������ִ���ֹͣ���롣�� VS2022 �򿪣��������޸ġ�
  call "%SourcePath%\vc_solution\vs2019_libmp3lame.sln"
)

:: ��װ include��lib �ļ�
if not exist "%VSSDK%\include\lame" (
  cd /d "%VSSDK%\include"
  md lame
)

copy /Y "%SourcePath%\output\%Platform2%\ReleaseSSE2\libmp3lame-static.lib" "%VSSDK%\lib\libmp3lame.lib"
copy /Y "%SourcePath%\output\%Platform2%\ReleaseSSE2\libmp3lame-static.lib" "%VSSDK%\lib\mp3lame.lib"
copy /Y "%SourcePath%\include\lame.h"                                       "%VSSDK%\include\lame\lame.h"
