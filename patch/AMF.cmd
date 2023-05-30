@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: �޸� VC �����ļ�Ϊ MT ����
call %BuildRootPath%Tools\vmt.exe "%SourcePath%"

:: VC ����̱���
echo ��ʼ VC ����̱���
MSBuild.exe %SourcePath%\amf\public\proj\vs2019\AmfMediaChromaKeyCommon.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=Release;Platform=%Platform1%^
  /flp1:LogFile=%SourcePath%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: ��� VC �����Ƿ��д���
if %errorlevel% NEQ 0 (
  echo ������ִ���ֹͣ���롣�� VS2022 �򿪣��������޸ġ�
  call "%SourcePath%\amf\public\proj\vs2019\AmfMediaChromaKeyCommon.sln"
  pause
)

:: ��װ include��lib �ļ�
if %BuildPlatform%==x86 (
	copy /Y "%SourcePath%\amf\bin\vs2017x32Release\AmfMediaChromaKeyCommon.lib" "%VSSDK%\lib\AmfMediaChromaKeyCommon.lib"
	copy /Y "%SourcePath%\amf\bin\vs2017x32Release\AmfMediaCommon.lib"          "%VSSDK%\lib\AmfMediaCommon.lib"
	xcopy /e /y /c /i "%SourcePath%\amf\public\include\*.*" "%VSSDK%\include\amf\"
) else (
	copy /Y "%SourcePath%\amf\bin\vs2017x64Release\AmfMediaChromaKeyCommon.lib" "%VSSDK%\lib\AmfMediaChromaKeyCommon.lib"
	copy /Y "%SourcePath%\amf\bin\vs2017x64Release\AmfMediaCommon.lib"          "%VSSDK%\lib\AmfMediaCommon.lib"
	xcopy /e /y /c /i "%SourcePath%\amf\public\include\*.*" "%VSSDK%\include\amf\"
)
