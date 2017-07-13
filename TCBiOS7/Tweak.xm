#define TWEAK
#import "../Prefs.h"
#import "../../PS.h"
#import "../apply.x"

%hook PLCameraView

- (BOOL)_previewShouldFillScreenForCameraMode: (int)mode
{
    return fullScreen && mode == 0 ? YES : %orig;
}

- (void)_layoutTopBarForOrientation:(int)orientation {
    %orig;
    applyBarEffectCorrectly(self._topBar, YES);
}

- (BOOL)_isSwipeToModeSwitchAllowed {
    return compactBottomBar ? YES : %orig;
}

%end

%hook CAMTopBar

- (void)_commonCAMTopBarInitialization
{
    %orig;
    applyBarEffectCorrectly(self, YES);
}

- (void)_updateBackgroundStyleAnimated:(BOOL)animated {
    %orig;
    if (hideTopBar)
        self._backgroundView.backgroundColor = [UIColor clearColor];
}

%end

%hook CAMBottomBar

- (void)_layoutForVerticalOrientation
{
    %orig;
    applyBarEffectCorrectly(self, NO);
}

- (void)_layoutForHorizontalOrientation {
    %orig;
    applyBarEffectCorrectly(self, NO);
}

%end

%hook CAMPhoneImagePickerSpec

- (BOOL)shouldCreateModeDial
{
    return compactBottomBar ? NO : %orig;
}

%end

%hook CAMPhoneApplicationSpec

- (BOOL)shouldCreateModeDial
{
    return compactBottomBar ? NO : %orig;
}

%end

%ctor
{
    if (IN_SPRINGBOARD)
        return;
    HaveObserver()
    callback();
    if (enabled) {
        openCamera7();
        %init;
    }
}
