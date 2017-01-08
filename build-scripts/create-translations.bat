@echo off

echo.
echo == Create Translations Files for Unknown-Horizons
echo. 

set TARGET_DIR="..\extracted"

cd "%TARGET_DIR%\extracted\unknown-horizons\development\"

python compile_translation_win.py

dir "%TARGET_DIR%"
