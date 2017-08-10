#import "../PS.h"
#import <dlfcn.h>

%ctor {
    if (isiOS10Up)
        dlopen("/Library/MobileSubstrate/DynamicLibraries/TCB/TCBiOS10.dylib", RTLD_LAZY);
    else if (isiOS9)
        dlopen("/Library/MobileSubstrate/DynamicLibraries/TCB/TCBiOS9.dylib", RTLD_LAZY);
    else if (isiOS8)
        dlopen("/Library/MobileSubstrate/DynamicLibraries/TCB/TCBiOS8.dylib", RTLD_LAZY);
    else if (isiOS7)
        dlopen("/Library/MobileSubstrate/DynamicLibraries/TCB/TCBiOS7.dylib", RTLD_LAZY);
#if !__LP64__
    else
        dlopen("/Library/Application Support/TCB/TCBiOS56.dylib", RTLD_LAZY);
#endif
}
