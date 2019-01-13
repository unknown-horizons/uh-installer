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

echo Python36
rem include Python from Appveyor
xcopy /SIQY C:\Python36 "%TARGET_DIR%\Python36"

echo Fife-Engine
move "%EXTRACTED_DIR%\Python36\Lib\site-packages\fife" "%TARGET_DIR%\Python36\Lib\site-packages\fife"
move "%EXTRACTED_DIR%\Python36\Lib\site-packages\libfife-0.4.2-py3.6.egg-info" "%TARGET_DIR%\Python36\Lib\site-packages\libfife-0.4.2-py3.6.egg-info"
dir "%EXTRACTED_DIR%\Python36\Lib\site-packages\"

echo Unknown-Horizons
move "%EXTRACTED_DIR%\unknown-horizons" "%TARGET_DIR%"

echo Copy needed dlls installer
copy "%LIBS%\vc_redist.x86.exe" "%TARGET_DIR%"

popd
