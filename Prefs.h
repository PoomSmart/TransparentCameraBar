#import <Foundation/Foundation.h>
#import "../PSPrefs.x"

NSString *tweakIdentifier = @"com.PS.TransparentCameraBar";
NSString *enabledKey = @"enabled";
NSString *fullScreenKey = @"fullScreen";
NSString *opacityTopBarKey = @"opacityTopBar";
NSString *hideTopBarKey = @"hideTopBar";
NSString *opacityBottomBarKey = @"opacityBottomBar";
NSString *hideBottomBarKey = @"hideBottomBar";
NSString *compactBottomBarKey = @"compactBottomBar";
NSString *topOpacityKey = @"topOpacity";
NSString *bottomOpacityKey = @"bottomOpacity";

#ifdef TWEAK

BOOL enabled;

BOOL opacityTopBar;
BOOL opacityBottomBar;
BOOL hideTopBar;
BOOL hideBottomBar;
BOOL fullScreen;
BOOL compactBottomBar;
CGFloat topOpacity;
CGFloat bottomOpacity;

HaveCallback() {
	GetPrefs()
	GetBool2(enabled, YES)
	GetBool2(fullScreen, YES)
	GetBool2(opacityTopBar, NO)
	GetBool2(hideTopBar, NO)
	GetBool2(opacityBottomBar, NO)
	GetBool2(hideBottomBar, NO)
	GetBool2(compactBottomBar, NO)
	GetCGFloat2(topOpacity, 1.0)
	GetCGFloat2(bottomOpacity, 1.0)
}

#endif
