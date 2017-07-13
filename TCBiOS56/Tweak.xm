#define TWEAK
#import "../Prefs.h"
#import "../../PS.h"

%hook UIImage

+ (UIImage *)imageNamed: (NSString *)name inBundle: (NSBundle *)bundle
{
    if ([bundle.bundleIdentifier isEqualToString:@"com.apple.PhotoLibrary"]) {
        if ([name isEqualToString:@"PLCameraButtonBarBlackShadow.png"] && (hideBottomBar || opacityBottomBar))
            return nil;
        if ([name isEqualToString:@"PLCameraButtonBarBlack.png"] && compactBottomBar)
            return nil;
    }
    return %orig;
}

%end

%hook PLCameraView

- (CGSize)_displaySizeForPreview
{
    return fullScreen ? [UIScreen mainScreen].bounds.size : %orig;
}

- (void)layoutSubviews {
    %orig;
    UIToolbar *bottomButtonBar = isiOS5 ? MSHookIvar<UIToolbar *>(self, "_cameraButtonBar") : MSHookIvar<UIToolbar *>(self, "_bottomButtonBar");
    if (opacityBottomBar)
        bottomButtonBar.alpha = bottomOpacity;
}

%end

%hook PLCropOverlay

- (void)layoutSubviews
{
    %orig;
    if (opacityBottomBar)
        MSHookIvar<PLCropOverlayBottomBar *>(self, "_bottomBar").alpha = bottomOpacity;
}

%end

%hook PLCropOverlayBottomBar

- (id)shutterButton
{
    [self _setVisibility:!hideBottomBar];
    return %orig;
}

- (void)setButtonBarMode:(int)mode animationDuration:(double)duration {
    %orig(hideBottomBar ? 1 : mode, duration);
}

- (void)setButtonBarMode:(int)mode {
    %orig(hideBottomBar ? 1 : mode);
}

%end

%hook PLCameraButtonBar

- (PLCameraButton *)cameraButton
{
    if ([self respondsToSelector:@selector(_setVisibility:)])
        [self _setVisibility:!hideBottomBar];
    else {
        if (hideBottomBar)
            [self _backgroundView].alpha = 0.0f;
    }
    return %orig;
}

+ (UIImage *)backgroundImageForButtonBarStyle:(int)buttonBarStyle {
    return compactBottomBar ? nil : %orig;
}

- (id)initWithFrame:(CGRect)frame {
    self = %orig;
    if (self) {
        if (opacityBottomBar && isiOS5)
            self.alpha = bottomOpacity;
    }
    return self;
}

- (void)setButtonBarMode:(int)mode {
    %orig(hideBottomBar ? 1 : mode);
}

- (void)setButtonBarMode:(NSInteger)mode animationDuration:(double)duration {
    %orig(hideBottomBar ? 1 : mode, duration);
}

%end

%ctor
{
    HaveObserver()
    callback();
    if (enabled) {
        openCamera6();
        %init;
    }
}
