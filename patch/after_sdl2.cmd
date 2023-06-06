@echo off
set VSSDK=%1

copy /Y "%VSSDK%\lib\sdl2-static.lib" "%VSSDK%\lib\sdl2.lib"
copy /Y "%VSSDK%\lib\sdl2-static.lib" "%VSSDK%\lib\sdl2.a"

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
echo Name: sdl2
echo Description: Simple DirectMedia Layer is a cross-platform multimedia library designed to provide low level access to audio, keyboard, mouse, joystick, 3D hardware via OpenGL, and 2D video framebuffer.
echo Version: 2.26.0
echo Requires:
echo Conflicts:
echo Libs: -L${libdir}  -lSDL2-static -lSDL2main -luser32 -lgdi32 -lwinmm -limm32 -lole32 -loleaut32 -lversion -luuid -ladvapi32 -lsetupapi -lshell32 -ldinput8 -lmsvcrt -mwindows
Cflags: -I${includedir} -I${includedir}/SDL2 -Dmain=SDL_main /Entry:SDL_main /SUBSYSTEM:CONSOLE
)>%VSSDK%\lib\pkgconfig\%CodeName%.pc
