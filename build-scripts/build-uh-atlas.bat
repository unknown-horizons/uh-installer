@echo off

echo.
echo == Unknown Horizons - Create Atlas Files
echo.

pushd extracted\unknown-horizons

C:\Python37\python.exe horizons\engine\generate_atlases.py 1024

popd