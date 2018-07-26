#define TWEAK
#import "../Prefs.h"
#import "../../PS.h"
#import "../apply.x"

%hook CAMBottomBar

- (void)_commonCAMBottomBarInitialization {
    %orig;
    applyBarEffectCorrectly(self, NO);
}

- (CGFloat)_opacityForBackgroundStyle:(NSInteger)style {
    return hideBottomBar ? 0.0 : %orig;
}

- (void)_layoutImageWellForTraitCollection:(UITraitCollection *)collection {
    %orig;
    if (![[self class] wantsVerticalBarForTraitCollection:collection] && compactBottomBar)
        self.imageWell.center = CGPointMake(self.imageWell.center.x, CGRectGetMidY(self.bounds) + 2.25 + (self.imageWell.bounds.size.height - [self.imageWell intrinsicContentSize].height) * 0.5);
}

- (void)_layoutFilterButtonForTraitCollection:(UITraitCollection *)collection {
    %orig;
    if (![[self class] wantsVerticalBarForTraitCollection:collection] && compactBottomBar)
        self.filterButton.center = CGPointMake(self.filterButton.center.x, CGRectGetMidY(self.bounds));
}

- (void)_layoutShutterButtonForTraitCollection:(UITraitCollection *)collection {
    %orig;
    if (![[self class] wantsVerticalBarForTraitCollection:collection] && compactBottomBar)
        self.shutterButton.center = CGPointMake(self.shutterButton.center.x, CGRectGetMidY(self.bounds));
}

%end

%hook CAMViewfinderViewController

- (void)_createModeDialIfNecessary {
    if (compactBottomBar && !IS_IPAD)
        return;
    %orig;
}

- (NSInteger)_aspectRatioForMode:(NSInteger)mode {
    return %orig(mode == 0 && fullScreen ? 1 : mode);
}

%end

%hook CAMViewfinderView

- (CGFloat)_interpolatedBottomBarHeightWithProposedHeight:(CGFloat)proposedHeight {
    CGFloat orig = %orig;
    if (compactBottomBar)
        orig -= 31 - 4.5;
    return orig;
}

- (void)_layoutTopBarForTraitCollection:(id)arg1 {
    %orig;
    applyBarEffectCorrectly(self.topBar, YES);
}

%end

%hook CAMTopBar

- (CGFloat)_opacityForBackgroundStyle:(NSInteger)style {
    return hideTopBar ? 0.0 : %orig;
}

%end

%ctor {
    if (IN_SPRINGBOARD)
        return;
    HaveObserver();
    callback();
    if (enabled) {
        openCamera9();
        %init;
    }
}
