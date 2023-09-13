@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\libxml2s.lib" "%VSSDK%\lib\libxml2.lib"

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo libdir=${prefix}/lib>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo includedir=${prefix}/include>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo modules=1>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo.>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Name: libXML>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Version: 2.12.0>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Description: libXML library version2.>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Libs: -L${libdir} -lxml2 -lzlib -llzma -liconv -lws2_32 >>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Libs.private: -lzlib -llzma -liconv -lws2_32 >>%VSSDK%\lib\pkgconfig\%CodeName%.pc 
@echo Cflags: -I${includedir}/libxml2 -DLIBXML_STATIC>>%VSSDK%\lib\pkgconfig\%CodeName%.pc

