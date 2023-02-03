:: Windows 下 VC 编译开源源代码
@echo off
setlocal enabledelayedexpansion
color A

@echo 运行本程序时，请确保 tools 已经安装了

set CodeName=%1
set Platform=%2
set RootPath=%~dp0
set ProjName=%CodeName%

@echo 编译 %CodeName%
title 编译 %CodeName%

:: 设置环境变量
call %RootPath%src\env.cmd %RootPath% %Platform% %CodeName%

:: 如果有 patch 补丁文件，给 CodeName 打补丁
set "PatchFileName=%RootPath%patch\%CodeName%.patch"
if exist %PatchFileName% (
  CD /D "%SourcePath%"
  git apply --ignore-space-change --ignore-whitespace -v %RootPath%patch\%CodeName%.patch
)

:: 执行编译前的动作
set "beforecmd=%RootPath%patch\before_%CodeName%.cmd"
if exist %beforecmd% (
  call %beforecmd% %RootPath% %SourcePath% %CodeName%
)

:: 开始编译
if exist %RootPath%patch\%CodeName%.cmd (
  :: 如果独立编译已存在，使用独立编译
  call %RootPath%patch\%CodeName%.cmd %RootPath% %Platform% %CodeName% %ProjName%
) else (
  :: 如果独立编译不存在，使用通用编译
  call %RootPath%src\CommonCore.cmd  %RootPath% %Platform% %CodeName% %ProjName%
)

:: 执行编译以后的动作
set "aftercmd=%RootPath%patch\after_%CodeName%.cmd"
if exist %aftercmd% (
  call %aftercmd% %VSSDK%
)

:: 源代码还原
cd /D "%SourcePath%"

:: git 源代码还原 
if exist "%SourcePath%\.git\" (
  git clean -d -fx -f
  git checkout .
)

:: svn 源代码还原 
if exist "%SourcePath%\.svn\" (
  svn cleanup --remove-ignored --remove-unversioned
  svn revert  --recursive .
)

:: 回到 vcs 目录
CD /D %RootPath%
