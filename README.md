# rtv-mod-tester-cmd
Batch file for easier mod testing on steam. Requires 7-zip, [Ryhon0's Mod Injector](https://github.com/Ryhon0/VostokMods).

# Usage
Place the `.bat` file into the folder of the mod you're developing and run it. 

# How it works.
1. Gets folder name (i.e. mod name)
2. Zips contents of folder (not the folder itself) into `<folder name>.zip`.
    - Windows only offers cmd utilities for compressing files into .tar archives.
4. Attempts to find the game folder in `C:` then `D:`. If this doesn't work, try editing this part of the script.
5. Moves the zip into the `/mods/` folder.
6. Starts the game with `--main-pack Injector.pck` as arguments.
