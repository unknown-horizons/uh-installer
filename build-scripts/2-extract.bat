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
echo Fifengine Python27 Installer
%ZIP% x libfife.win32-py3.6.zip -o%TARGET_DIR%

echo.
echo === Extracting Unknown-Horizons into the folder %TARGET_DIR%
echo.

echo.
echo Unknown-Horizons
%ZIP% x unknown-horizons.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\unknown-horizons*" "%TARGET_DIR%\unknown-horizons"

popd
