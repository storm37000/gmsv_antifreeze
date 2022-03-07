# gmsv_antifreeze
[![Build status](https://ci.appveyor.com/api/projects/status/2o3hieuy8rybcc73?svg=true)](https://ci.appveyor.com/project/storm37000/gmsv-antifreeze)

Automatically kill a frozen/locked up Garrysmod srcds instance. <br>
Dont forget to download and install the lua file from the zip or tar.gz file in the release.

## Compiling

Compiling out of the box is only supported on appveyor.  You can take the blocks of code out of the if (top block for Windows, bottom for Linux) if you do not want to use appveyor.  For Linux non Appveyor this would require manually installing the dependencies to run the ps1 file and things like git and svn.
Simply run the build.ps1 file in your VS2019 or Linux compiler env and it will handle everything automatically and output both 32 and 64 bit binaries.
