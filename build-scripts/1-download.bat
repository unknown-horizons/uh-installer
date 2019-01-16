@echo off

echo.
echo == Download
echo.

echo.
echo === Downloading Unknown-Horizons using Aria2c
echo.

build-tools\aria2\aria2c.exe -i download-lists\unknown-horizons.txt --conditional-get=true --allow-overwrite=false --auto-file-renaming=false
