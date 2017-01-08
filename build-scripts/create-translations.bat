@echo off

echo.
echo == Create Translations Files
echo. 

set TARGET_DIR="..\extracted"

echo.
echo Unknown-Horizons
cd "%TARGET_DIR%\extracted\unknown-horizons\unknown-horizons-master\development\"
python compile_translation_win.py

dir "%TARGET_DIR%"
