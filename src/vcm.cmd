:: ���� VC ����̱���
@echo off
set RootPath=%1
set BuildTempPath=%2
set VCProjectName=%3
set VCPlatformXXX=%4

:: �޸� VC �����ļ�Ϊ MT ����
call %RootPath%Tools\vmt.exe "%BuildTempPath%"

:: �����ļ��Ƿ����
if not exist "%BuildTempPath%\%VCProjectName%.sln" goto bEnd

:: VC ����̱���
MSBuild.exe "%BuildTempPath%\%VCProjectName%.sln" /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
	/target:Build /property:Configuration=Release;Platform=%VCPlatformXXX%^
	/flp1:LogFile=%BuildTempPath%\zxerr.log;Verbosity=diagnostic;errorsonly^
	/flp2:LogFile=%BuildTempPath%\zxwas.log;Verbosity=diagnostic;warningsonly

:: ��� VC �����Ƿ��д���
if %errorlevel% NEQ 0 (
	echo ������ִ���ֹͣ���롣����������� VS2022 �򿪣��������޸�Դ�롣
	pause
	call "%BuildTempPath%\%VCProjectName%.sln"
	pause
)

:bEnd
