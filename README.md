# gmsv_antifreeze
[![Build status](https://ci.appveyor.com/api/projects/status/2o3hieuy8rybcc73?svg=true)](https://ci.appveyor.com/project/storm37000/gmsv-antifreeze)

Automatically kill a frozen/locked up Garrysmod srcds instance.

## Installation
Click on releases and download the dll for your OS and bit of srcds that you are running. <br>
Dont forget to download and install the lua file from the zip or tar.gz file in the release.

## Use
`antifreeze.SetTimeout(number)` **[1.2+]** sets the timeout that if your server stays frozen before the watchdog kills the process.  This can be set at any time. <br>
`antifreeze.WatchdogStop()` **[1.0+]** Kills the watchdog, can only be restarted by a map change or server restart. <br>
`antifreeze.RestartServer()` **[1.3+]** stops/crashes your server so that it can restart.  Easy way in lua to perform a server restart. <br>
`antifreeze.WatchDogSetPaused(bool)` **[1.3+]** Pauses the watchdog if true, unpauses if false.

## Compiling
Compiling out of the box is only supported on appveyor. <br>
You can take the blocks of code out of the if (top block for Windows, bottom for Linux) if you do not want to use appveyor.  For Linux non Appveyor this would require manually installing the dependencies to run the ps1 file and things like git and svn. <br>
Simply run the build.ps1 file in your VS2019 or Linux compiler env and it will handle everything automatically and output both 32 and 64 bit binaries.
