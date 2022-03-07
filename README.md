# gmsv_antifreeze
[![Build status](https://ci.appveyor.com/api/projects/status/2o3hieuy8rybcc73?svg=true)](https://ci.appveyor.com/project/storm37000/gmsv-antifreeze)

Automatically kill a frozen/locked up Garrysmod srcds instance.

## Installation
Click on releases and download the dll for your OS and bit of srcds that you are running. <br>
Dont forget to download and install the lua file from the zip or tar.gz file in the release.

## Use
`antifreeze.SetTimeout(number)` sets the timeout that your server stays frozen before the watchdog kills the process.  This can be set at any time. <br>
`antifreeze.WatchdogStop()` Kills the watchdog, can only be restarted by a map change or server restart. <br>
`antifreeze.RestartServer()` Restarts/crashes your server.  Easy way in lua to preform a server restart.

## Compiling
Compiling out of the box is only supported on appveyor. <br>
You can take the blocks of code out of the if (top block for Windows, bottom for Linux) if you do not want to use appveyor.  For Linux non Appveyor this would require manually installing the dependencies to run the ps1 file and things like git and svn. <br>
Simply run the build.ps1 file in your VS2019 or Linux compiler env and it will handle everything automatically and output both 32 and 64 bit binaries.
