@echo off

echo.
echo == Unknown Horizons - Create Translation Files
echo.

set PATH=%PATH%;C:\projects\uh-installer\build-tools\gettext\bin

pushd extracted\unknown-horizons\development

C:\python36\python.exe compile_translation_win.py

popd