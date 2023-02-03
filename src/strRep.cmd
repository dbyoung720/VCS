@echo off
setlocal EnableDelayedExpansion
 
set ReplacePath=%1
set FileType=%2
set strOld=%3
set strNew=%4
 
CD /D %ReplacePath%

for /f %%i in ('dir /b /s /a:-d %FileType%') do (
  powershell -Command "(gc %%i) -replace '%strOld%', '%strNew%' | Out-File %%i -encoding UTF8"
)