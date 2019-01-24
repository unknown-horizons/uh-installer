@echo off

echo.
echo == Copy
echo.

set EXTRACTED_DIR="%CD%\extracted"
set TARGET_DIR="%CD%\repackage"

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

pushd extracted

echo.
echo === Copying Python37 (from Appveyor)
echo. 
xcopy /SIQY C:\Python37 "%TARGET_DIR%\Python37"

echo.
echo === Copying Fife
echo.
xcopy /SIQY "%EXTRACTED_DIR%\Python37\Lib\site-packages\fife" "%TARGET_DIR%\Python37\Lib\site-packages\fife"
copy "%EXTRACTED_DIR%\Python37\Lib\site-packages\libfife-0.4.2-py3.7.egg-info" "%TARGET_DIR%\Python37\Lib\site-packages"

echo.
echo === Copying Unknown-Horizons
echo.
xcopy /SIQY "%EXTRACTED_DIR%\unknown-horizons" "%TARGET_DIR%\unknown-horizons"

echo.
echo === Copying VCRedistributable
echo.
copy "..\vc_redist\vc_redist.x86.exe" "%TARGET_DIR%"

popd
