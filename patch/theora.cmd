@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: �޸� VC �����ļ�Ϊ MT ����
call %BuildRootPath%Tools\vmt.exe "%SourcePath%"

:: VC ����̱���
echo ��ʼ VC ����̱���
MSBuild.exe %SourcePath%\win32\VS2010\libtheora_static.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=Release;Platform=%Platform1%^
  /flp1:LogFile=%SourcePath%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: ��� VC �����Ƿ��д���
if %errorlevel% NEQ 0 (
  echo ������ִ���ֹͣ���롣�� VS2022 �򿪣��������޸ġ�
  call "%SourcePath%\win32\VS2010\libtheora_static.sln"
)

:: ��װ include��lib �ļ�
copy /Y "%SourcePath%\win32\VS2010\%Platform2%\Release\libtheora_static.lib" "%VSSDK%\lib\libtheora.lib"
copy /Y "%SourcePath%\win32\VS2010\%Platform2%\Release\libtheora_static.lib" "%VSSDK%\lib\theoraenc.lib"
copy /Y "%SourcePath%\win32\VS2010\%Platform2%\Release\libtheora_static.lib" "%VSSDK%\lib\theoradec.lib"
xcopy /e /y /c /i "%SourcePath%\include\theora\*.h" "%VSSDK%\include\theora\"

