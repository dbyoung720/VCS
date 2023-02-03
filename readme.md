VCS
=============

# VCS is an compile open source code based on windows platform

- [酒悶嶄猟](readmeCN.md)

## I. Development purpose
    1、Under Windows, compile open source code with VS2022, and compile it into MT static library;
    2、Small: the whole file system size of VCS is less than 300K(no include patch dir);
    3、Fast : VC compilation uses multi-process compilation, which is fast;
    4、Open : You can add custom compilation to the patch directory according to examples;

## II. Instructions
    1、Compile tools: VS2022 is must. For other compile tools, use scoop for unified management. Therefore, scoop and its compile tools must be installed before using vcs;
    2、Install scoop and its compilation tools: execute "tools.cmd x86" or "tools.cmd x64" to install scoop and its compile tools; It takes a little time. But after installation, it will be done once and for all;
    3、VCS does not download the source code. You need to download the source code yourself and put it in the "F:\source". Of course, you can modified in "env.cmd";
    4、Execute "vcs zlib x86" to compile open source code (if you install scoop is x86 platform);
    5、Execute "vcs zlib x64" to compile open source code (if you install scoop is x64 platform);
    6、If you are familiar with the code of vcs, you can modify it according to your own needs; It is relatively easy, with comments;
    7、Because vcs does not support association compile, you must compile the association library first, and then compile the specified library. For example, before compile the ffmpeg library, you must first compile other third-party libraries;
    8、Because the msys2/meson compile uses a relative directory, the program and the directory where the source code is saved must be a logical disk, cannot cross drive letter;
    9、If cmake compile fails, cmake-gui will be opened automatically and can be modified by yourself; If the compile of VC project fails, VC project will be opened automatically and can be modified by yourself;
    