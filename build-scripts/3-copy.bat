@echo off

echo.
echo == Copy
echo.

set ZIP="..\build-tools\7zip\7z.exe"
set EXTRACTED_DIR="..\extracted"
set TARGET_DIR="..\repackage"

echo.
echo === Prepare repackaging folder %TARGET_DIR%
echo.

pushd extracted

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo Fifengine Dependencies
move "%EXTRACTED_DIR%\fifengine-includes" "%TARGET_DIR%"

echo Fifengine Python27 Installer 
move "%EXTRACTED_DIR%\libfife.win32-py2.7.msi" "%TARGET_DIR%"

echo Unknown-Horizons
move "%EXTRACTED_DIR%\unknown-horizons" "%TARGET_DIR%"

popd
