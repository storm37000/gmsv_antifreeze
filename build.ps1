if($env:APPVEYOR_BUILD_WORKER_IMAGE -eq "Visual Studio 2019"){
	$content = Get-Content -Path '.\src\main.cpp'
	$newContent = $content -replace 'LUA->PushNumber(0);//replace_build_number_here_automatic!', "LUA->PushNumber($env:APPVEYOR_BUILD_NUMBER);"
	$newContent | Set-Content -Path '.\src\main.cpp'
	svn checkout https://github.com/Facepunch/gmod-module-base/branches/development/include ..\include\
	msbuild ".\projects\windows\gmsv_antifreeze.sln" /property:Configuration=Release /p:Platform="Win32" /verbosity:normal /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
	msbuild ".\projects\windows\gmsv_antifreeze.sln" /property:Configuration=Release64 /p:Platform="x64" /verbosity:normal /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
}else{
	$content = Get-Content -Path './src/main.cpp'
	$newContent = $content -replace 'LUA->PushNumber(0);//replace_build_number_here_automatic!', "LUA->PushNumber($env:APPVEYOR_BUILD_NUMBER);"
	$newContent | Set-Content -Path './src/main.cpp'
	sudo apt-get update
	sudo apt-get install gcc-multilib g++-multilib -y
	svn checkout https://github.com/Facepunch/gmod-module-base/branches/development/include ../include/
	cd ./projects/linux
	make config=release
	make config=release64
}