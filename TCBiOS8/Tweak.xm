#define TWEAK
#import "../Prefs.h"
#import "../../PS.h"
#import "../apply.x"
#import <UIKit/UIView+Private.h>

%hook CAMTopBar

- (void)_commonCAMTopBarInitialization {
    %orig;
    applyBarEffectCorrectly(self, YES);
}

%end

%hook CAMCameraView

- (BOOL)_previewShouldFillScreenForCameraMode: (NSInteger)mode {
    return fullScreen && mode == 0 ? YES : %orig;
}

- (void)_layoutTopBarForOrientation:(NSInteger)orientation {
    %orig;
    applyBarEffectCorrectly(self._topBar, YES);
}

- (BOOL)_isSwipeToModeSwitchAllowed {
    return compactBottomBar ? YES : %orig;
}

%end

%hook CAMTopBar

- (void)setAlpha: (CGFloat)alpha {
    %orig(opacityTopBar && alpha != 0.0f ? topOpacity : alpha);
}

- (void)_updateBackgroundStyleAnimated:(BOOL)animated {
    %orig;
    if (hideTopBar)
        self._backgroundView.backgroundColor = [UIColor clearColor];
}

%end

%hook CAMBottomBar

- (void)setAlpha: (CGFloat)alpha {
    %orig(opacityBottomBar && alpha != 0.0 ? bottomOpacity : alpha);
}

- (void)_setupHorizontalShutterButtonConstraints {
    %orig;
    if ([self modeDial] == nil) {
        NSString *shutterButtonName = @"CAMShutterButton";
        NSArray *constraints = [self cam_constraintsForKey:shutterButtonName];
        [self cam_removeAllConstraintsForKey:shutterButtonName];
        NSMutableArray *newConstraints = [NSMutableArray array];
        [newConstraints addObjectsFromArray:constraints];
        CAMShutterButton *shutterButton = [self.shutterButton retain];
        UIView *spacer = [[self _shutterButtomBottomLayoutSpacer] retain];
        NSMutableArray *deleteConstraints = [NSMutableArray array];
        for (NSLayoutConstraint *layout in newConstraints) {
            if (layout.firstItem == shutterButton && layout.firstAttribute == NSLayoutAttributeBottom)
                [deleteConstraints addObject:layout];
        }
        if (deleteConstraints.count) {
            for (NSLayoutConstraint *layout in deleteConstraints) {
                [newConstraints removeObject:layout];
            }
        }
        [self retain];
        NSLayoutConstraint *centerY = [[NSLayoutConstraint constraintWithItem:shutterButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-4.5] retain];
        [newConstraints addObject:centerY];
        [self cam_addConstraints:newConstraints forKey:shutterButtonName];
        [self release];
        [centerY release];
        [spacer release];
        [shutterButton release];
    }
}

- (void)_layoutForVerticalOrientation {
    %orig;
    applyBarEffectCorrectly(self, NO);
}

- (void)_layoutForHorizontalOrientation {
    %orig;
    applyBarEffectCorrectly(self, NO);
}

- (void)_updateBackgroundStyleAnimated:(BOOL)animated {
    %orig;
    if (hideBottomBar)
        self.backgroundView.backgroundColor = [UIColor clearColor];
}

%end

%hook CAMPhoneImagePickerSpec

- (BOOL)shouldCreateModeDial {
    return compactBottomBar ? NO : %orig;
}

%end

%hook CAMPhoneApplicationSpec

- (BOOL)shouldCreateModeDial {
    return compactBottomBar ? NO : %orig;
}

%end

%ctor {
    if (IN_SPRINGBOARD)
        return;
    HaveObserver();
    callback();
    if (enabled) {
        openCamera8();
        %init;
    }
}
