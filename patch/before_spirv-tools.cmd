@echo off
set RootPath=%1
set SourcePath=%2
set CodeName=%3

xcopy /e /y /c /i "%DriverPath%\SPIRV-Headers\*.*"   "%SourcePath%\external\SPIRV-Headers\" 
