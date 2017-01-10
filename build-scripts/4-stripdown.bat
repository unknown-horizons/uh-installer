@echo off

echo.
echo == Stripdown
echo.

echo.
echo === Stripping packages in ..\repackage
echo.

pushd repackage

echo.
echo Python27
rd /s /q "..\repackage\Python27\Doc"
rd /s /q "..\repackage\Python27\tcl"
rd /s /q "..\repackage\Python27\Scripts"
rd /s /q "..\repackage\Python27\Tools"
rm       "..\repackage\Python27\NEWS.txt"
rm       "..\repackage\Python27\w9xpopen.exe"

echo.
echo Fifengine Dependencies
rd /s /q "..\repackage\fifengine-includes\lib"
rd /s /q "..\repackage\fifengine-includes\include"

popd
