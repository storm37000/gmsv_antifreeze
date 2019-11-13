workspace "gmsv_antifreeze"
    configurations { "Debug", "Debug64", "Release", "Release64" }
    location ( "projects/" .. os.get() )

project "gmsv_antifreeze"
    kind         "SharedLib"
    language     "C++"
	cppdialect	"C++11"
	editandcontinue "Off"
	vectorextensions "SSE3"
    includedirs  "../include/"
	targetprefix ""
	targetextension ".dll"
    
    if os.is( "windows" ) then targetsuffix "_win32" end
    if os.is( "macosx" )  then targetsuffix "_osx"   end
    if os.is( "linux" )   then targetsuffix "_linux" end

    configuration "Debug"
		architecture "x86"
		symbols	"On"
        optimize "Debug"

    configuration "Debug64"
		architecture "x86_64"
		symbols	"On"
        optimize "Debug"

    configuration "Release"
		architecture "x86"
		symbols	"Off"
        optimize "Speed"
		staticruntime "Off"
		floatingpoint "Fast"
		flags { "LinkTimeOptimization","NoFramePointer" }

    configuration "Release64"
		architecture "x86_64"
		symbols	"Off"
        optimize "Speed"
		staticruntime "Off"
		floatingpoint "Fast"
		flags { "LinkTimeOptimization","NoFramePointer" }

    files
    {
        "src/**.*",
        "../include/**.*"
    }
