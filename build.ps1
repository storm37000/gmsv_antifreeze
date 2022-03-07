if($env:APPVEYOR_BUILD_WORKER_IMAGE -eq "Visual Studio 2019"){
	$contentold = Get-Content -Path '.\src\main.cpp'
	$contentold.Replace('LUA->PushNumber(0);//replace_build_number_here_automatic!', "LUA->PushNumber($env:APPVEYOR_BUILD_NUMBER);") | Set-Content -Path '.\src\main.cpp'
	echo "downloading and extracting gmod headers"
	Invoke-WebRequest -Uri "https://github.com/Facepunch/gmod-module-base/archive/refs/heads/development.zip" -OutFile "..\gmod.zip"
	Expand-Archive "..\gmod.zip" ..\
	Move-Item "..\gmod-module-base-development\include\" ..\include
	echo "downloading and extracting premake"
	Invoke-WebRequest -Uri "https://github.com/premake/premake-core/releases/download/v5.0.0-beta1/premake-5.0.0-beta1-windows.zip" -OutFile "premake-5.0.0-beta1-windows.zip"
	Expand-Archive "premake-5.0.0-beta1-windows.zip" .\
	./premake5.exe --os=windows vs2019
	msbuild ".\projects\windows\gmsv_antifreeze.sln" /property:Configuration=Release /p:Platform="Win32" /verbosity:normal /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
	msbuild ".\projects\windows\gmsv_antifreeze.sln" /property:Configuration=Release64 /p:Platform="x64" /verbosity:normal /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
}else{
	$contentold = Get-Content -Path './src/main.cpp'
	$contentold.Replace('LUA->PushNumber(0);//replace_build_number_here_automatic!', "LUA->PushNumber($env:APPVEYOR_BUILD_NUMBER);") | Set-Content -Path './src/main.cpp'
	sudo apt-get update
	sudo apt-get install gcc-multilib g++-multilib -y
	mkdir ../include
	echo "downloading and extracting gmod headers"
	svn checkout https://github.com/Facepunch/gmod-module-base/branches/development/include ../include/
	echo "downloading and extracting premake"
	wget https://github.com/premake/premake-core/releases/download/v5.0.0-beta1/premake-5.0.0-beta1-linux.tar.gz
	tar -xzf "premake-5.0.0-beta1-linux.tar.gz"
	chmod 700 ./premake5
	./premake5 --os=linux gmake2
	cd ./projects/linux
	make config=release
	make config=release64
}