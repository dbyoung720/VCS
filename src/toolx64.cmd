@echo off
setlocal EnableDelayedExpansion

set strToolsX64=aria2/7zip/vulkan/Sysinternals/pandoc/oraclejdk/oraclejre8/ant/bazel/ccache/emscripten/ghostscript/inno-setup/innoextract/innounp/jom/nsis/nginx/anaconda3/python27/python39/postman/scons/ragel/isx/wixtoolset/cuda/octave/ispc/git/sliksvn/mercurial/ruby/pkg-config/perl/cmake/xmake/meson/curl/bison/winflexbison/ninja/swig/nasm/yasm/vswhere/llvm/doxygen/gnuplot/julia/miktex/graphviz/go/rust/rust-msvc/msys2/depends/wireshark/lazarus/notepad2/notepad3/notepadplusplus/obs-studio/ollydbg/gimp/xnviewmp/qbittorrent/ffmpeg-batch/mpc-be/vlc/mpv/sqlitespy/heidisql/currports/currprocess/deviceioview/dllexportviewer/driverview/filetypesman/injecteddll/installedcodec/ipnetinfo/myuninstaller/netbscanner/networkconnectlog/networkcounterswatch/networkopenedfiles/networktrafficview/ntfslinksview/openedfilesview/processthreadsview/regdllview/shellexview/shellmenuview/socketsniff/videocacheview/websitesniffer/webvideocap/whatinstartup/wincrashreport

:splitx64
for /f "tokens=1,* delims=/" %%i in ("%strToolsX64%") do (
  set ToolName=%%i
  if not exist "%ScoopDir%\apps\%ToolName%" (
    echo 安装 scoop 工具包 %ToolName%
    call scoop install %ToolName%
  )
  set strToolsX64=%%j
)
if not "%strToolsX64%"=="" goto splitx64
