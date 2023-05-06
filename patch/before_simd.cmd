@echo off
set RootPath=%1
set SourcePath=%2
set CodeName=%3

call %SourcePath%\prj\cmd\GetVersion.cmd %SourcePath% 1
