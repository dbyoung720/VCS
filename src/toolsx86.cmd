@echo off
setlocal EnableDelayedExpansion

set "strToolsX86=aria2/7zip/vulkan/Sysinternals/oraclejdk/oraclejre8/ant/bazel/ccache/emscripten/ghostscript/inno-setup/innoextract/innounp/jom/nsis/nginx/python27/python39/postman/scons/ragel/isx/wixtoolset/cuda/octave/ispc/git/sliksvn/mercurial/ruby/pkg-config/perl/cmake/xmake/meson/curl/bison/winflexbison/ninja/swig/nasm/yasm/vswhere/llvm/doxygen/gnuplot/julia/miktex/graphviz/go/rust/rust-msvc/msys2/depends/lazarus/notepad2/notepad3/notepadplusplus/ollydbg/gimp/xnviewmp/mpc-be/vlc/mpv/sqlitespy/heidisql/currports/currprocess/deviceioview/dllexportviewer/driverview/filetypesman/injecteddll/installedcodec/ipnetinfo/myuninstaller/netbscanner/networkconnectlog/networkcounterswatch/networkopenedfiles/networktrafficview/ntfslinksview/openedfilesview/processthreadsview/regdllview/shellexview/shellmenuview/socketsniff/videocacheview/websitesniffer/webvideocap/whatinstartup/wincrashreport"
:splitx86
for /f "tokens=1,* delims=/" %%i in ("%strToolsX86%") do (
  set ToolName=%%i
  if not exist "%ScoopDir%\apps\%ToolName%" (
    echo 安装 scoop 工具包 %ToolName%
    if "%ToolName%" == "meson" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "ninja" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "oraclejdk" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "miktex" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "cuda" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "emscripten" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "msys2" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "gnuplot" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "doxygen" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "bazel" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "postman" (
      call scoop install %ToolName%
    ) else if "%ToolName%" == "Sysinternals" (
      call scoop install %ToolName%
    ) else (
      call scoop install %ToolName% -a x86
    )
  )
  set strToolsX86=%%j
)
if not "%strToolsX86%"=="" goto splitx86
