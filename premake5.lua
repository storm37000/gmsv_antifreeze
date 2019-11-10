workspace "gmsv_antifreeze"
    configurations { "Debug", "Release" }
    location ( "projects/" .. os.get() )

project "gmsv_antifreeze"
    kind         "SharedLib"
    architecture "x86"
    language     "C++"
    includedirs  "../include/"
	targetprefix ""
	targetextension ".dll"
    
    if os.is( "windows" ) then targetsuffix "_win32" end
    if os.is( "macosx" )  then targetsuffix "_osx"   end
    if os.is( "linux" )   then targetsuffix "_linux" end

    configuration "Debug"
		symbols	"On"
        optimize "Debug"

    configuration "Release"
		symbols	"Off"
        optimize "Speed"
		staticruntime "Off"
		floatingpoint "Fast"
		buildoptions {"-march=native"}
		flags { "LinkTimeOptimization","NoFramePointer" }

    files
    {
        "src/**.*",
        "../include/**.*"
    }
