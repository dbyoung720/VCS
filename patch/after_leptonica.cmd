@echo off
set VSSDK=%1

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

(
prefix=%InstallPCPath%
exec_prefix=${prefix}/bin
libdir=${prefix}/lib
includedir=${prefix}/include
echo.
Name: leptonica
Description: An open source C library for efficient image processing and image analysis operations
Version: 1.84.0
Requires.private:  zlib libpng libjpeg libtiff-4 libwebp libwebpmux libopenjp2 
Libs: -L${libdir} -lleptonica-1.84.0 zlib libpng libjpeg libtiff-4 libwebp libwebpmux libopenjp2 zstd giflib liblzma libsharpyuv
Libs.private:  -lgif -lm
Cflags: -I${includedir} -I${includedir}/leptonica
)>%VSSDK%\lib\pkgconfig\%CodeName%.pc
