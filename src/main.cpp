#include "GarrysMod/Lua/Interface.h"
#include <ctime>
#include <iostream>
#include <thread>
#include <exception>
#ifdef __linux__
	#include <sys/prctl.h>
#endif

std::time_t srvrtime = 0;
unsigned short killtime = 60;
bool flag = true;
bool restart = false;
bool paused = false;

void af_watchdog()
{
#ifdef __linux__
	prctl(PR_SET_NAME,"antifreeze\0",NULL,NULL,NULL);
#endif
	std::cout << "Antifreeze: Watchdog starting up." << std::endl;
	unsigned short timeout = 0;
	while(flag){
		std::this_thread::sleep_for(std::chrono::seconds(1));
//		std::cout << "srvrtime (thread) is " << srvrtime << "\n";
		if(srvrtime == 0 || paused){
			//do nothing
		}else if(restart){
				std::cout << "Manual restart requested, killing process..." << std::endl;
				exit(0);
		}else if(srvrtime >= (std::time(nullptr))-2){
			if (timeout != 0){
				timeout = 0;
				std::cout << "Server caught back up!" << std::endl;
			}
		}else{
			timeout++;
			std::cout << "Server is behind! (" << timeout << ")" << std::endl;
			if(timeout == killtime){
				std::cout << "Server Frozen! killing process..." << std::endl;
				*( (int*) NULL ) = 0; //throw a segfault
				//throw std::exception();
			}
		}
	}
	std::cout << "Antifreeze: Watchdog shut down. Please change map or restart server to start it again if you wish." << std::endl;
}
std::thread t1(af_watchdog);

LUA_FUNCTION( RestartServer )
{
	restart = true;
	return 0;
}
LUA_FUNCTION( SetTimeout )
{
	killtime = static_cast<unsigned short>(LUA->CheckNumber(1));
	return 0;
}
LUA_FUNCTION( WatchDogPing )
{
	srvrtime = std::time(nullptr);
//	std::cout << "srvrtime (WatchDogPing) is " << srvrtime << "\n";
	return 0;
}
LUA_FUNCTION( WatchDogStop )
{
	flag = false;
	t1.join();
	return 0;
}
GMOD_MODULE_OPEN()
{
	LUA->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB);
	LUA->CreateTable();
	LUA->PushNumber(1);
	LUA->SetField( -2, "version" );
	LUA->PushNumber(0);//replace_build_number_here_automatic!
	LUA->SetField( -2, "build" );
	LUA->PushCFunction(WatchDogStop);
	LUA->SetField( -2, "WatchdogStop" );
	LUA->PushCFunction(SetTimeout);
	LUA->SetField( -2, "SetTimeout" );
	LUA->PushCFunction(RestartServer);
	LUA->SetField( -2, "RestartServer" );
	LUA->SetField( -2, "antifreeze" );
	LUA->GetField(-1, "timer");
	LUA->GetField(-1, "Create");
	LUA->PushString("antifreeze_watchdog");
	LUA->PushNumber(1);
	LUA->PushNumber(0);
	LUA->PushCFunction(WatchDogPing);
	LUA->Call(4, 0);
	LUA->Pop(2);
	return 0;
}
GMOD_MODULE_CLOSE()
{
	flag = false;
	t1.join();
	return 0;
}