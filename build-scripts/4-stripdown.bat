@echo off

echo.
echo == Stripdown
echo.

echo.
echo === Stripping packages in ..\repackage
echo.

pushd repackage

echo.
echo Unknown-Horizons
rm       "..\repackage\unknown-horizons\Mypy.ini"
rm       "..\repackage\unknown-horizons\.editorconfig"

popd
