@echo off

echo.
echo == Download
echo.

echo.
echo === Downloading Build Artifacts using Aria2c
echo.

build-tools\aria2\aria2c.exe -i build-scripts\download-list.txt --conditional-get=true --allow-overwrite=false --auto-file-renaming=false
