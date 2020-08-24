#include "GarrysMod/Lua/Interface.h"
#include <ctime>
#include <iostream>
#include <thread>
#include <exception>
#include <atomic>

std::atomic<std::time_t> srvrtime (0);
bool flag = true;
unsigned short killtime = 60;

void foo() 
{
	unsigned short timeout = 0;
	while(flag){
		std::this_thread::sleep_for(std::chrono::seconds(1));
		if(srvrtime >= (std::time(nullptr))-2){
			if (timeout != 0){
				timeout = 0;
				std::cout << "Server caught back up!\n";
			}
		}else{
			if(srvrtime != 0){
				timeout++;
				std::cout << "Server is behind! (" << timeout << ")\n";
				if(timeout == killtime){
					std::cout << "Server Frozen! killing process...\n";
					throw std::exception();
				}
			}
		}
	}
}
std::thread t1(foo);
LUA_FUNCTION( WatchDogPing )
{
	srvrtime = std::time(nullptr);
	return 0;
}
LUA_FUNCTION( WatchDogStop )
{
	flag = false;
	t1.join();
	return 0;
}
LUA_FUNCTION( SetTimeout )
{
	killtime = static_cast<unsigned short>( LUA->CheckNumber( 1 ) );
	return 0;
}
GMOD_MODULE_OPEN()
{
	LUA->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB);// Push global table
	LUA->CreateTable();
	LUA->PushNumber(1);
	LUA->SetField( -2, "version" );
	LUA->PushNumber(0);//replace_build_number_here_automatic!
	LUA->SetField( -2, "build" );
	LUA->PushCFunction(WatchDogStop);
	LUA->SetField( -2, "WatchdogStop" );
	LUA->PushCFunction(SetTimeout);
	LUA->SetField( -2, "SetTimeout" );
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
	LUA->PushNil();
	LUA->SetField( GarrysMod::Lua::SPECIAL_GLOB, "antifreeze" );
	t1.join();
	return 0;
}
