@echo off

echo.
echo == Extract
echo.

set ZIP="%CD%\build-tools\7zip\7z.exe"
set TARGET_DIR="%CD%\extracted"

pushd downloads

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo.
echo === Extracting Fifengine into the folder %TARGET_DIR%
echo.

echo.
echo Fifengine Python36 Installer
%ZIP% x "C:\projects\uh-installer\fife\Python36.zip" -o%TARGET_DIR%

echo.
echo === Extracting Unknown-Horizons into the folder %TARGET_DIR%
echo.

echo.
echo Unknown-Horizons
%ZIP% x unknown-horizons.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\unknown-horizons*" "%TARGET_DIR%\unknown-horizons"

popd
