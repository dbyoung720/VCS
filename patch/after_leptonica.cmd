@echo off
set VSSDK=%1

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

(
echo prefix=%InstallPCPath%
echo exec_prefix=${prefix}/bin
echo libdir=${prefix}/lib
echo includedir=${prefix}/include
echo.
echo Name: leptonica
echo Description: An open source C library for efficient image processing and image analysis operations
echo Version: 1.84.0
echo Requires.private:  zlib libpng libjpeg libtiff-4 libwebp libwebpmux libopenjp2 
echo Libs: -L${libdir} -lleptonica-1.84.0 -lzlib -llibpng -ljpeg -ltiff -llibwebp -llibwebpmux -lopenjp2 -lzstd -lgiflib -lliblzma -llibsharpyuv
echo Libs.private:  -lgif -lm
echo Cflags: -I${includedir} -I${includedir}/leptonica
)>%VSSDK%\lib\pkgconfig\%CodeName%.pc
