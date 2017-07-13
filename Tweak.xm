#import "../PS.h"
#import <dlfcn.h>

%ctor
{
	if (isiOS10Up)
		dlopen("/Library/Application Support/TCB/TCBiOS10.dylib", RTLD_LAZY);
	else if (isiOS9)
		dlopen("/Library/Application Support/TCB/TCBiOS9.dylib", RTLD_LAZY);
	else if (isiOS8)
		dlopen("/Library/Application Support/TCB/TCBiOS8.dylib", RTLD_LAZY);
	else if (isiOS7)
		dlopen("/Library/Application Support/TCB/TCBiOS7.dylib", RTLD_LAZY);
	else if (isiOS56)
		dlopen("/Library/Application Support/TCB/TCBiOS56.dylib", RTLD_LAZY);
}
