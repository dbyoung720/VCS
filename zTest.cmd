@echo off

set platform=x64

:: 压缩类
call vcs zlib    %platform%
call vcs lz4     %platform%
call vcs xz      %platform%
call vcs bzip2   %platform%
call vcs z3      %platform%
call vcs zziplib %platform%
call vcs zstd    %platform%
call vcs zenlib  %platform%
call vcs snappy  %platform%

:: 测试类
call vcs googletest %platform%
call vcs gflags     %platform%
call vcs glog       %platform%

:: 图像类
call vcs libpng        %platform%
call vcs libjpeg-turbo %platform%
call vcs openjpeg      %platform%
call vcs giflib        %platform%
call vcs libtiff       %platform%
call vcs Webp          %platform%
call vcs fribidi       %platform%
call vcs IMath         %platform%
call vcs openexr       %platform%
call vcs glib          %platform%

:: 文本类
call vcs libiconv   %platform%
call vcs icu        %platform%
call vcs harfbuzz   %platform%
call vcs fontconfig %platform%
call vcs libass     %platform%
call vcs libxml2    %platform%
call vcs leptonica  %platform%
call vcs tesseract  %platform%
call vcs assimp     %platform%
call vcs pcre2      %platform%

:: 网络类
call vcs openssl    %platform%
call vcs libtorrent %platform%

:: 音频类
call vcs ogg          %platform%
call vcs vorbis       %platform%
call vcs theora       %platform%
call vcs flac         %platform%
call vcs opus         %platform%
call vcs mpg123       %platform%
call vcs lame         %platform%
call vcs opencore-amr %platform%
call vcs opus         %platform%

:: 视频类
call vcs OpenCL-Headers   %platform%
call vcs Vulkan-Headers   %platform%
call vcs Vulkan-Loader    %platform%
call vcs AviSynth-Headers %platform%
call vcs SPIRV-Headers    %platform%
call vcs SPIRV-Cross      %platform%
rem call vcs SPIRV-Tools      %platform%
call vcs glslang          %platform%
call vcs x264     %platform%
call vcs x265     %platform%
call vcs openh264 %platform%
call vcs dav1d    %platform%
call vcs libmfx   %platform%
call vcs rav1e    %platform%
call vcs kvazaar  %platform%
call vcs libvpx   %platform%
call vcs libavif  %platform%
call vcs AMF      %platform%
call vcs libuv    %platform%
call vcs AOM      %platform%
call vcs frei0r   %platform%

:: 语言类
call vcs ispc      %platform%
call vcs ccache    %platform%
call vcs leveldb   %platform%
call vcs lmdb      %platform%
call vcs hdf5      %platform%
call vcs boost     %platform%
call vcs sqlite3   %platform%
call vcs llvm      %platform%
call vcs QT5       %platform%
call vcs VTK       %platform%
call vcs opencv    %platform%
call vcs slint     %platform%

pause
