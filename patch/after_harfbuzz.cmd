@echo off
set VSSDK=%1

:: ��װ PC �ļ�
set "InstallPCPath=%VSSDK:\=/%"

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo includedir=${prefix}/include>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo libdir=${prefix}/lib>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo.>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Name: harfbuzz>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Description: HarfBuzz text shaping library>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Version: 6.0.0>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Libs: -L${libdir} -lharfbuzz>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Cflags: -I${includedir}/harfbuzz>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
