@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

copy /y "%BuildRootPath%Patch\%SourceCodeName%\vsyasm_%platform1%.exe" "%SourcePath%\build\yasm\vsyasm.exe"

:: VC ����̱���
echo ��ʼ VC ����̱���
MSBuild.exe %SourcePath%\build\kvazaar_VS2015.sln /nologo /consoleloggerparameters:Verbosity=minimal /maxcpucount:16 /nodeReuse:true^
  /target:Build /property:Configuration=Release;Platform=%platform2%^
  /flp1:LogFile=%SourcePath%\zxerr1.log;Verbosity=diagnostic;errorsonly^
  /flp2:LogFile=%SourcePath%\zxwas1.log;Verbosity=diagnostic;warningsonly

:: ��� VC �����Ƿ��д���
if %errorlevel% NEQ 0 (
  echo ������ִ���ֹͣ���롣�� VS2022 �򿪣��������޸ġ�
  call "%SourcePath%\build\kvazaar_VS2015.sln"
  pause
)

copy /Y "%SourcePath%\build\%platform2%-Release-libs\kvazaar_lib.lib" "%VSSDK%\lib\kvazaar.lib"
copy /Y "%SourcePath%\src\kvazaar.h"                                  "%VSSDK%\include\kvazaar.h"

:: ��װ PC �ļ�
set "InstallPCPath=%VSSDK:\=/%"

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo incdir=${prefix}/include>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo.>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo Name: libkvazaar>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo Description: Open-source HEVC encoder>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo Version: 2.1.0>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo Libs: -L${libdir} -lkvazaar>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo Libs.private: >>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
@echo Cflags: -I${incdir}>>%VSSDK%\lib\pkgconfig\%SourceCodeName%.pc
