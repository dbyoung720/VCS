@echo off

rem :: 压缩类
rem call vcs zlib    x86
rem call vcs lz4     x86
rem call vcs xz      x86
rem call vcs bzip2   x86
rem call vcs z3      x86
rem call vcs zziplib x86
rem call vcs zstd    x86
rem call vcs zenlib  x86
rem call vcs snappy  x86

rem :: 测试类
rem call vcs googletest x86
rem call vcs gflags     x86
rem call vcs glog       x86

rem :: 图像类
rem call vcs libpng        x86
rem call vcs libjpeg-turbo x86
rem call vcs openjpeg      x86
rem call vcs giflib        x86
rem call vcs libtiff       x86
rem call vcs Webp          x86
rem call vcs fribidi       x86
rem call vcs IMath         x86
rem call vcs openexr       x86

rem :: 文本类
rem call vcs libiconv   x86
rem call vcs icu        x86
rem call vcs harfbuzz   x86
rem call vcs fontconfig x86
rem call vcs libass     x86
rem call vcs libxml2   x86

rem :: 音频类
rem call vcs ogg          x86
rem call vcs vorbis       x86
rem call vcs theora       x86
rem call vcs flac         x86
rem call vcs opus         x86
rem call vcs mpg123       x86
rem call vcs lame         x86
rem call vcs opencore-amr x86

rem :: 视频类
rem call vcs Vulkan-Headers x86
rem call vcs Vulkan-Loader  x86
rem call vcs SPIRV-Headers  x86
rem call vcs SPIRV-Cross    x86
rem call vcs SPIRV-Tools    x86
rem call vcs glslang        x86
rem call vcs x264     x86
rem call vcs x265     x86
rem call vcs openh264 x86
rem call vcs dav1d    x86
rem call vcs libmfx   x86
rem call vcs rav1e    x86
call vcs kvazaar  x86
call vcs libvpx    x86
call vcs libavif   x86
call vcs AMF       x86
call vcs libuv     x86
call vcs AOM       x86

:: 语言类
call vcs lmdb      x86
call vcs hdf5      x86
call vcs boost     x86
call vcs sqlite3   x86
call vcs llvm      x86
call vcs QT5       x86
call vcs VTK       x86
call vcs opencv    x86

pause
