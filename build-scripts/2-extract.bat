@echo off

echo.
echo == Extract
echo.

set ZIP="..\build-tools\7zip\7z.exe"
set TARGET_DIR="..\extracted"

pushd downloads

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo.
echo === Extracting Fifengine Dependencies into the folder %TARGET_DIR%
echo.

echo.
echo Fifengine Dependencies
%ZIP% x libfife-dependencies.zip -o..\extracted\fifengine-includes > nul

echo.
echo Fifengine Python27 Installer
copy libfife.win32-py2.7.msi "%TARGET_DIR%\libfife.win32-py2.7.msi"

echo.
echo === Extracting Unknown-Horizons into the folder %TARGET_DIR%
echo.

echo.
echo Unknown-Horizons
%ZIP% x unknown-horizons.zip -o%TARGET_DIR% > nul
move "%TARGET_DIR%\unknown-horizons*" "%TARGET_DIR%\unknown-horizons"

popd
