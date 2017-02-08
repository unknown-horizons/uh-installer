@echo off

echo.
echo == Copy
echo.

set ZIP="..\build-tools\7zip\7z.exe"
set EXTRACTED_DIR="..\extracted"
set TARGET_DIR="..\repackage"
set LIBS="..\libs\"

echo.
echo === Prepare repackaging folder %TARGET_DIR%
echo.

pushd extracted

if not exist %TARGET_DIR% (mkdir %TARGET_DIR%)

echo Python27
rem include Python from Appveyor
xcopy /SIQY C:\Python27 "%TARGET_DIR%\Python27"

echo Python27.dll
rem add the mising python27.dll to the python folder
copy C:\Windows\SysWOW64\python27.dll "%TARGET_DIR%\Python27"

echo Fife-Engine
move "%EXTRACTED_DIR%\Python27" "%TARGET_DIR%\Python27"

echo Unknown-Horizons
move "%EXTRACTED_DIR%\unknown-horizons" "%TARGET_DIR%"

echo Copy needed dlls installer
copy "%LIBS%\vc_redist.x86.exe" "%TARGET_DIR%"

popd
