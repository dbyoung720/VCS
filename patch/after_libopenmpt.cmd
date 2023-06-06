@echo off
set VSSDK=%1

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

(
echo prefix=%InstallPCPath%
echo exec_prefix=${prefix}
echo includedir=${prefix}/include
echo libdir=${prefix}/lib
echo.
echo Name: libopenmpt
echo Description: Tracker module player based on OpenMPT
echo Version: 
echo Requires.private: zlib vorbis vorbisfile mpg123
echo Libs: -L${prefix}/lib -lopenmpt -lzlib -lvorbis -lvorbisfile -lmpg123
echo Libs.private: 
echo Cflags: -I${prefix}/include
)>%VSSDK%\lib\pkgconfig\%CodeName%.pc
