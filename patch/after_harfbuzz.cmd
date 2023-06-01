@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\harfbuzz.lib"        "%VSSDK%\lib\libharfbuzz.lib"
copy /Y "%VSSDK%\lib\harfbuzz-subset.lib" "%VSSDK%\lib\libharfbuzz-subset.lib"


:: 安装 PC 文件
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

