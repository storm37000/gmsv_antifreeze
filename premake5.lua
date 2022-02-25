workspace "gmsv_antifreeze"
	configurations { "Release", "Release64", "Debug", "Debug64" }
	location ( "projects/" .. os.get() )

project "gmsv_antifreeze"
	kind         "SharedLib"
	language     "C++"
	cppdialect	"C++11"
	editandcontinue "Off"
	includedirs  "../include/"
	targetprefix ""
	targetextension ".dll"
	staticruntime "Off"
	floatingpoint "Fast"
	files
	{
		"src/**.*",
		"../include/**.*"
	}
	
	configuration "Debug"
		architecture "x86"
		symbols	"On"
		optimize "Debug"
		if os.is( "windows" ) then targetsuffix "_win32" end
		if os.is( "macosx" )  then targetsuffix "_osx"   end
		if os.is( "linux" )   then targetsuffix "_linux" end

	configuration "Debug64"
		architecture "x86_64"
		symbols	"On"
		optimize "Debug"
		if os.is( "windows" ) then targetsuffix "_win64" end
		if os.is( "macosx" )  then targetsuffix "_osx64"   end
		if os.is( "linux" )   then targetsuffix "_linux64" end

	configuration "Release"
		architecture "x86"
		symbols	"Off"
		optimize "Speed"
		omitframepointer "On"
		flags { "LinkTimeOptimization" }
		if os.is( "windows" ) then targetsuffix "_win32" end
		if os.is( "macosx" )  then targetsuffix "_osx"   end
		if os.is( "linux" )   then targetsuffix "_linux" end

	configuration "Release64"
		architecture "x86_64"
		symbols	"Off"
		optimize "Speed"
		omitframepointer "On"
		flags { "LinkTimeOptimization" }
		if os.is( "windows" ) then targetsuffix "_win64" end
		if os.is( "macosx" )  then targetsuffix "_osx64"   end
		if os.is( "linux" )   then targetsuffix "_linux64" end