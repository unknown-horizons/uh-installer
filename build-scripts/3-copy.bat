@echo off

echo.
echo == Copy
echo.

set EXTRACTED_DIR="%CD%\extracted"
set TARGET_DIR="%CD%\repackage"

echo.
echo === Prepare repackaging folder %TARGET_DIR%
echo.

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

pushd extracted

echo Copying Python36 (from Appveyor)
xcopy /SIQY C:\Python36 "%TARGET_DIR%\Python36"

echo Copying Fife
xcopy /SIQY "%EXTRACTED_DIR%\Python36\Lib\site-packages\fife" "%TARGET_DIR%\Python36\Lib\site-packages\fife"
copy "%EXTRACTED_DIR%\Python36\Lib\site-packages\libfife-0.4.2-py3.6.egg-info" "%TARGET_DIR%\Python36\Lib\site-packages"

echo Copying Unknown-Horizons
xcopy /SIQY "%EXTRACTED_DIR%\unknown-horizons" "%TARGET_DIR%"

echo Copying VCRedistributable
copy "..\vc_redist\vc_redist.x86.exe" "%TARGET_DIR%"

popd
