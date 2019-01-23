@echo off

echo.
echo == Copy
echo.

set ZIP="%CD%\build-tools\7zip\7z.exe"
set EXTRACTED_DIR="%CD%\extracted"
set TARGET_DIR="%CD%\repackage"
set LIBS="%CD%\libs\"

echo.
echo === Prepare repackaging folder %TARGET_DIR%
echo.

pushd extracted

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo Copying Python36 (from Appveyor)
xcopy /SIQY C:\Python36 "%TARGET_DIR%\Python36"

echo Copying Fife
xcopy /SIQY "%EXTRACTED_DIR%\Python36\Lib\site-packages\fife" "%TARGET_DIR%\Python36\Lib\site-packages\fife"
xcopy /SIQY "%EXTRACTED_DIR%\Python36\Lib\site-packages\libfife-0.4.2-py3.6.egg-info" "%TARGET_DIR%\Python36\Lib\site-packages\libfife-0.4.2-py3.6.egg-info"

echo Copying Unknown-Horizons
xcopy /SIQY "%EXTRACTED_DIR%\unknown-horizons" "%TARGET_DIR%"

echo Copying VCRedistributable
copy "%LIBS%\vc_redist.x86.exe" "%TARGET_DIR%"

popd
