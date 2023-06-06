@echo off
set VSSDK=%1

:: 安装 PC 文件
set "InstallPCPath=%VSSDK:\=/%"

(
echo prefix=%InstallPCPath%
echo exec_prefix=${prefix}
echo libdir=${exec_prefix}/lib
echo includedir=${prefix}/include
echo.
echo Name: hdf5
echo Description: HDF5 (Hierarchical Data Format 5) Software Library
echo Version: 1.15.0
echo.
echo Cflags: -I${includedir}
echo Libs: -L${libdir} -lzlib -lshlwapi
echo Requires: 
echo Libs.private:  -lhdf5  -lshlwapi -lzlib
echo Requires.private: 
)>%VSSDK%\lib\pkgconfig\%CodeName%.pc
