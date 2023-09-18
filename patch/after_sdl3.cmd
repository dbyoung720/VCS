@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\sdl3-static.lib" "%VSSDK%\lib\sdl3.lib"
copy /Y "%VSSDK%\lib\sdl3-static.lib" "%VSSDK%\lib\sdl3.a"

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

(
echo # sdl pkg-config source file
echo.
echo prefix=%InstallPCPath%
echo exec_prefix=${prefix}
echo libdir=${exec_prefix}/lib
echo includedir=${prefix}/include
echo.
echo Name: sdl3
echo Description: Simple DirectMedia Layer is a cross-platform multimedia library designed to provide low level access to audio, keyboard, mouse, joystick, 3D hardware via OpenGL, and 2D video framebuffer.
echo URL: https://www.libsdl.org/
echo Version: 3.0.0
echo Requires:
echo Conflicts:
echo Libs: -L${libdir}  -lSDL3-static -lkernel32 -luser32 -lgdi32 -lwinmm -limm32 -lole32 -loleaut32 -lversion -luuid -ladvapi32 -lsetupapi -lshell32 -ldinput8 -lmsvcrt -mwindows
echo Cflags: -I${includedir} -I${includedir}/sdl3 -I$<BUILD_INTERFACE:F:/Source/SDL3/src/video/khronos> -Dmain=SDL_main /Entry:SDL_main /SUBSYSTEM:CONSOLE
)>%VSSDK%\lib\pkgconfig\%CodeName%.pc
