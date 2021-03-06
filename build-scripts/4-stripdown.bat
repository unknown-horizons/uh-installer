@echo off

echo.
echo == Stripdown
echo.

set TARGET_DIR="%CD%\repackage"

echo.
echo === Stripping packages in %TARGET_DIR%
echo.

pushd repackage

echo.
echo === Stripping Unknown-Horizons
echo.

cd unknown-horizons

rem Remove all .pyc and .pyo files
del /S /Q *.pyc
del /S /Q *.pyo
del /Q unknown-horizons.wpr
del /Q stage_build_mac.py
del /Q CONTRIBUTING.md
rd /S /Q tests
  
del /Q Mypy.ini
del /Q .editorconfig
del /Q .coveragerc
del /Q .gitattributes
del /Q .gitignore
del /Q .isort.cfg
del /Q .travis.yml

rem Removing non-atlas graphics...
rd /S /Q content\gfx\base
rd /S /Q content\gfx\buildings
rd /S /Q content\gfx\units
rd /S /Q content\gfx\terrain

rem Removing dev stuff - Not needed folder for gamer version of installer
rd /S /Q development

rem Remove translation artifacts
del /S /Q "po\*.po~"

rem Remove __pycache__ folders and content
for /d /r . %%d in (__pycache__) do @if exist "%%d" rd /s/q "%%d" 

cd..

echo.
echo === Stripping Python
echo.

cd Python37

del /Q NEWS.txt
rd /S /Q Doc
rd /S /Q Scripts
rd /S /Q tcl
rd /S /Q Tools

rem Remove __pycache__ folders and content
for /d /r . %%d in (__pycache__) do @if exist "%%d" rd /s/q "%%d" 

cd..

popd
