@echo off
setlocal

:: get parent folder name
for %%I in ("%cd%") do set FolderName=%%~nxI

:: set zip file name to folder name
set ZipFile=%FolderName%.zip

:: delete existing zip file
if exist "%ZipFile%" del "%ZipFile%"

:: compress folder contents to zip file
7z a -tzip "%ZipFile%" * -xr!%ZipFile%

:: copy zip file to game mods folder
set "GameDir=D:\SteamLibrary\steamapps\common\Road to Vostok Demo"
set "ModDir=%GameDir%\mods"
if exist "%ModDir%" (
    if exist "%ZipFile%" (

        copy /Y "%ZipFile%" "%TargetDir%\"~
        echo Zip copied to %TargetDir%

        :: delete transferred zip file
        del "%ZipFile%"

        :: start the game with the mod installed; game shows logs in console
        "%GameDir%\Public_Demo_2_v2.exe" --main-pack "%GameDir%\mod-injector.pck"
    )
) else (
    
    echo Target directory not found: %ModDir%

    :: delete zip file
    if exist "%ZipFile%" del "%ZipFile%"

)
