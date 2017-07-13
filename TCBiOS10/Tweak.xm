#define TWEAK
#import "../Prefs.h"
#import "../../PS.h"
#import "../apply.x"

%hook CAMBottomBar

- (void)_commonCAMBottomBarInitializationInitWithLayoutStyle: (NSInteger)style {
    %orig;
    applyBarEffectCorrectly(self, NO);
}

- (void)setBackgroundStyle:(NSInteger)style animated:(BOOL)animated {
    %orig;
    applyBarEffectCorrectly(self, NO);
}

- (CGFloat)_opacityForBackgroundStyle:(NSInteger)style {
    return hideBottomBar ? 0.0 : opacityBottomBar ? bottomOpacity : %orig;
}

- (void)_layoutImageWellForLayoutStyle:(NSInteger)style {
    %orig;
    if (![[self class] wantsVerticalBarForLayoutStyle:style] && compactBottomBar)
        self.imageWell.center = CGPointMake(self.imageWell.center.x, CGRectGetMidY(self.bounds) + 2.25 + (self.imageWell.bounds.size.height - [self.imageWell intrinsicContentSize].height) * 0.5);
}

- (void)_layoutShutterButtonForLayoutStyle:(NSInteger)style {
    %orig;
    if (![[self class] wantsVerticalBarForLayoutStyle:style] && compactBottomBar)
        self.shutterButton.center = CGPointMake(self.shutterButton.center.x, CGRectGetMidY(self.bounds));
}

%end

%hook CAMViewfinderView

- (CGFloat)_interpolatedBottomBarHeightWithProposedHeight: (CGFloat)proposedHeight {
    CGFloat orig = %orig;
    if (compactBottomBar)
        orig -= 31 - 4.5;
    return orig;
}

%end

%hook CAMViewfinderViewController

- (void)_createModeDialIfNecessary {
    if (compactBottomBar && !IS_IPAD)
        return;
    %orig;
}

- (void)updateControlVisibilityAnimated:(BOOL)animated {
    %orig;
    applyBarEffectCorrectly(self._bottomBar, NO);
}

- (NSInteger)_aspectRatioForMode:(NSInteger)mode {
    return mode == 0 && fullScreen ? 1 : %orig;
}

%end

%hook CAMViewfinderView

- (void)_layoutTopBarForLayoutStyle: (id)arg1 {
    %orig;
    applyBarEffectCorrectly(self.topBar, YES);
}

%end

%hook CAMTopBar

- (CGFloat)_opacityForBackgroundStyle: (NSInteger)style {
    return hideTopBar ? 0.0 : opacityTopBar ? topOpacity : %orig;
}

%end

%ctor {
    if (IN_SPRINGBOARD)
        return;
    HaveObserver()
    callback();
    if (enabled) {
        openCamera10();
        %init;
    }
}