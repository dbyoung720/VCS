@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

:: ±‡“Î‘¥¥˙¬Î  
CD /D "%BuildPathX%"
bash -c "export PKG_CONFIG_PATH=%PKG_CONFIG_PATH%"
bash -c "%InvSourcePath%/configure --target-os=%Platform6% --prefix='%InvVSSDK%' --toolchain=msvc --disable-shared --enable-static --enable-pic --disable-doc --enable-debug --enable-runtime-cpudetect --disable-autodetect --enable-w32threads --enable-d3d11va --enable-dxva2 --enable-mediafoundation --disable-inline-asm --cc=cl.exe --cxx=cl.exe --windres=rc.exe --ld=link.exe --ar='ar-lib lib.exe' --enable-nonfree --enable-gpl --enable-version3 --enable-ffmpeg --enable-ffplay --enable-ffprobe --enable-avcodec --enable-avdevice --enable-avformat --enable-avfilter --enable-postproc --enable-swresample --enable-swscale --disable-alsa --enable-amf --enable-libaom --enable-libass --disable-avisynth --enable-bzlib --enable-libdav1d --enable-libfdk-aac --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-iconv --enable-libilbc --enable-lzma --enable-libmp3lame --enable-libmodplug --enable-cuda --enable-nvenc --enable-nvdec --enable-cuvid --enable-ffnvcodec --enable-opencl --enable-opengl --enable-libopenh264 --enable-libopenjpeg --enable-libopenmpt --enable-openssl --enable-libopus --enable-sdl2 --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --disable-libtensorflow --disable-libtesseract --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxml2 --enable-zlib --enable-libsrt --enable-libmfx --enable-encoder=h264_qsv --enable-decoder=h264_qsv --enable-cross-compile --extra-cflags='-DHAVE_UNISTD_H=0' --pkg-config-flags=--static --enable-optimizations --arch=x86 --enable-asm --enable-x86asm"
bash -c "make -j 8"
bash -c "make install"
