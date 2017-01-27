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

echo Python27
rem include Python from Appveyor
xcopy /SIQY C:\Python27 "%TARGET_DIR%\Python27"

echo Python27.dll
rem add the mising python27.dll to the python folder
copy C:\Windows\SysWOW64\python27.dll "%TARGET_DIR%\Python27"

echo Fifengine Python27 Installer 
move "%EXTRACTED_DIR%\libfife.win32-py2.7.msi" "%TARGET_DIR%"

echo Unknown-Horizons
move "%EXTRACTED_DIR%\unknown-horizons" "%TARGET_DIR%"

echo Copy needed dlls vcruntime140.dll msvcp140.dll
mkdir %TARGET_DIR%\Python27\Lib\site-packages\fife
copy "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\redist\x86\Microsoft.VC140.CRT\vcruntime140.dll" "%TARGET_DIR%\Python27\Lib\site-packages\fife\vcruntime140.dll"
copy "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\redist\x86\Microsoft.VC140.CRT\msvcp140.dll" "%TARGET_DIR%\Python27\Lib\site-packages\fife\msvcp140.dll"

popd
