@echo off
set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4
set LangToolset=msvc-14.3

:: ±‡“Î
CD /D "%SourcePath%"
if exist b2.exe (
  b2 install --build-dir=%BuildPathX% --prefix=%VSSDK% --includedir=%VSSDK%\include -sEXPAT_INCLUDE=%VSSDK%\include -sEXPAT_LIBPATH=%VSSDK%\lib --toolset=%LangToolset% address-model=%Platform3% link=static runtime-link=static  threading=multi variant=release
) else (
  call bootstrap.bat
  b2 install --build-dir=%BuildPathX% --prefix=%VSSDK% --includedir=%VSSDK%\include -sEXPAT_INCLUDE=%VSSDK%\include -sEXPAT_LIBPATH=%VSSDK%\lib --toolset=%LangToolset% address-model=%Platform3% link=static runtime-link=static  threading=multi variant=release
)

:: ºÏ≤È VC ±‡“Î «∑Ò”–¥ÌŒÛ
if %ERRORLEVEL% NEQ 0 (
  echo ±‡“Î≥ˆœ÷¥ÌŒÛ£¨Õ£÷π±‡“Î
  pause
)
