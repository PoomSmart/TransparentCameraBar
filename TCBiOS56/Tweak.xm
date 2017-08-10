#define TWEAK
#import "../Prefs.h"

%hook UIImage

+ (UIImage *)imageNamed: (NSString *)name inBundle: (NSBundle *)bundle {
    if ([bundle.bundleIdentifier isEqualToString:@"com.apple.PhotoLibrary"]) {
        if (hideBottomBar || opacityBottomBar) {
            if ([name isEqualToString:@"PLCameraButtonBarBlackShadow.png"])
                return nil;
            if (hideBottomBar) {
                if ([name isEqualToString:@"PLCameraButtonBarSwitchWellBackground.png"])
                    name = @"PLCameraButtonBarSwitchWellClear.png";
                else if ([name isEqualToString:@"PLHandle.png"])
                    name = @"PLHandleClear.png";
            }
        }
        if (compactBottomBar && [name isEqualToString:@"PLCameraButtonBarBlack.png"])
            return nil;
    }
    return %orig(name, bundle);
}

%end

%hook PLCameraView

- (CGSize)_displaySizeForPreview {
    return fullScreen ? [UIScreen mainScreen].bounds.size : %orig;
}

- (void)layoutSubviews {
    %orig;
    UIToolbar *bottomButtonBar = isiOS6Up ? MSHookIvar<UIToolbar *>(self, "_bottomButtonBar") : MSHookIvar<UIToolbar *>(self, "_cameraButtonBar");
    if (opacityBottomBar)
        bottomButtonBar.alpha = bottomOpacity;
}

%end

%hook PLCropOverlay

- (void)layoutSubviews {
    %orig;
    if (opacityBottomBar)
        MSHookIvar<PLCropOverlayBottomBar *>(self, "_bottomBar").alpha = bottomOpacity;
}

%end

%hook PLCropOverlayBottomBar

- (id)shutterButton {
    [self _setVisibility:!hideBottomBar];
    return %orig;
}

- (void)setButtonBarMode:(NSInteger)mode animationDuration:(double)duration {
    %orig(hideBottomBar ? 1 : mode, duration);
}

- (void)setButtonBarMode:(NSInteger)mode {
    %orig(hideBottomBar ? 1 : mode);
}

%end

%hook PLCameraButtonBar

- (PLCameraButton *)cameraButton {
    if ([self respondsToSelector:@selector(_setVisibility:)])
        [self _setVisibility:!hideBottomBar];
    else {
        if (hideBottomBar)
            [self _backgroundView].alpha = 0.0;
    }
    return %orig;
}

+ (UIImage *)backgroundImageForButtonBarStyle:(NSInteger)buttonBarStyle {
    return compactBottomBar && isiOS6Up ? nil : %orig;
}

- (id)initWithFrame:(CGRect)frame {
    self = %orig;
    if (self && opacityBottomBar && isiOS5)
        self.alpha = bottomOpacity;
    return self;
}

- (void)setButtonBarMode:(NSInteger)mode {
    %orig(hideBottomBar ? 1 : mode);
}

- (void)setButtonBarMode:(NSInteger)mode animationDuration:(double)duration {
    %orig(hideBottomBar ? 1 : mode, duration);
}

%end

%ctor {
    HaveObserver();
    callback();
    if (enabled) {
        openCamera6();
        %init;
    }
}
