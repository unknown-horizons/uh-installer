@echo off

echo.
echo == Unknown Horizons - Create Atlas Files
echo.

pushd extracted\unknown-horizons

python.exe setup.py build_i18n

popd