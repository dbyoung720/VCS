:: ÎÄ¼þ×Ö·û´®ËÑË÷Ìæ»»
@echo off
setlocal EnableDelayedExpansion
 
set RePath=%1
set FiType=%2
set strOld=%3
set strNew=%4
 
CD /D %RePath%

for /f %%i in ('dir /b /s /a:-d %FiType%') do (
  powershell -Command "(gc %%i) -replace '%strOld%', '%strNew%' | Out-File %%i -encoding UTF8"
)