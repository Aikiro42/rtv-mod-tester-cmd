@echo off
setlocal

:: get parent folder name
for %%I in ("%cd%") do set FolderName=%%~nxI

:: set zip file name to folder name
set ZipFile=%FolderName%.zip

:: delete existing zip file
if exist "%ZipFile%" del "%ZipFile%"

:: attempt to compress folder contents to zip file (requires 7zip)
7z a -tzip "%ZipFile%" * -xr!%ZipFile%

if not exist "%ZipFile%" (
    echo Mod failed to zip. Terminating.
    pause
    exit
) else (
    echo Mod zipped successfully.
)

:: find game folder
set "GameDir=C:\Program Files (x86)\Steam\steamapps\common\Road to Vostok Demo"
if not exist "%GameDir%" set "GameDir=D:\SteamLibrary\steamapps\common\Road to Vostok Demo"
if not exist "%GameDir%" (
    echo !!! ERROR: Failed to find game folder.
    echo !!! Please edit this batch file so that it finds it.
    echo !!! Terminating.
    pause
    exit
) else (
    echo Found game folder.
)

:: Prompt if mod is to be tested; otherwise, zip file stays in mod folder
:: for easy uploading to modworkshop
set /P c=Enter [G/g] to open the game and test the mod: 
if /I "%c%" NEQ "G" (
    if /I "%c%" NEQ "g" exit 0
)

:: find mods folder
set "ModDir=%GameDir%\mods"
if not exist "%ModDir%" (
    echo Creating mods folder...
    mkdir "%ModDir%"
)

:: move zip file to mod dir
copy /Y "%ZipFile%" "%ModDir%\"
del "%ZipFile%"

echo Mod zip file moved to mods folder: %TargetDir%

:: start the game with the mod installed; game shows logs in console
echo Starting game...
"%GameDir%\Public_Demo_2_v2.exe" --main-pack "%GameDir%\Injector.pck"
