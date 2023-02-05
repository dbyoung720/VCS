@echo off

:: 压缩类
call vcs zlib    x86
call vcs lz4     x86
call vcs xz      x86
call vcs bzip2   x86
rem call vcs z3      x86
call vcs zziplib x86
call vcs zstd    x86
call vcs zenlib  x86
call vcs snappy  x86

:: 测试类
call vcs googletest x86
call vcs gflags     x86
call vcs glog       x86

:: 图像类
call vcs libpng        x86
call vcs libjpeg-turbo x86
call vcs openjpeg      x86
call vcs giflib        x86
call vcs libtiff       x86
call vcs Webp          x86
call vcs fribidi       x86
call vcs IMath         x86
call vcs openexr       x86

:: 文本类
call vcs libiconv   x86
call vcs icu        x86
call vcs harfbuzz   x86
call vcs fontconfig x86
call vcs libass     x86
call vcs libxml2   x86

:: 音频类
call vcs ogg          x86
call vcs vorbis       x86
call vcs theora       x86
call vcs flac         x86
call vcs opus         x86
call vcs mpg123       x86
call vcs lame         x86
call vcs opencore-amr x86

:: 视频类
call vcs Vulkan-Headers x86
call vcs Vulkan-Loader  x86
call vcs SPIRV-Headers  x86
call vcs SPIRV-Cross    x86
rem call vcs SPIRV-Tools    x86
rem call vcs glslang        x86
call vcs x264     x86
call vcs x265     x86
call vcs openh264 x86
call vcs dav1d    x86
call vcs libmfx   x86
call vcs rav1e    x86
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
