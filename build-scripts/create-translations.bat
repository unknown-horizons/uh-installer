@echo off

echo.
echo == Create Translations files
echo. 

set TARGET_DIR="..\extracted"
set msgfmt "..\build-tools\gettext\bin\msgfmt.exe"

echo.
echo Unknwon-Horizons
cd "%TARGET_DIR%\extracted\unknown-horizons\unknown-horizons-master\development"
compile_translation_win.py

dir "%TARGET_DIR%"
