@echo off

echo.
echo == Create Translations files
echo. 

set TARGET_DIR="..\extracted"

echo.
echo Unknwon-Horizons
cd "%TARGET_DIR%\extracted\unknown-horizons\unknown-horizons-master\development\"
python compile_translation_win.py

dir "%TARGET_DIR%"
