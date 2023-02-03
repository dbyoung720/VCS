@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\libpng16_static.lib" "%VSSDK%\lib\libpng.lib"
copy /Y "%VSSDK%\lib\libpng16_static.lib" "%VSSDK%\lib\libpng16.lib"

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo includedir=${prefix}/include/libpng16>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo.>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Name: libpng>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Description: Loads and saves PNG files>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Version: 1.6.39>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Requires.private: zlib>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Libs: -L${libdir} -llibpng16 -lzlib>>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Libs.private: -lzlib >>%VSSDK%\lib\pkgconfig\%CodeName%.pc
@echo Cflags: -I${includedir}>>%VSSDK%\lib\pkgconfig\%CodeName%.pc

@echo prefix=%InstallPCPath%>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo exec_prefix=${prefix}>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo libdir=${exec_prefix}/lib>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo includedir=${prefix}/include/libpng16>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo.>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo Name: libpng>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo Description: Loads and saves PNG files>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo Version: 1.6.39>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo Requires.private: zlib>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo Libs: -L${libdir} -llibpng16 -lzlib>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo Libs.private: -lzlib >>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
@echo Cflags: -I${includedir}>>%VSSDK%\lib\pkgconfig\%CodeName%16.pc
