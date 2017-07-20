#import <objc/runtime.h>

static void applyBarEffectCorrectly(UIView *orig, BOOL isTop) {
    if (orig == nil)
        return;
    UIView *backgroundView = nil;
    object_getInstanceVariable(orig, "_backgroundView", (void * *)&backgroundView);
    if (backgroundView == nil)
        object_getInstanceVariable(orig, "__backgroundView", (void * *)&backgroundView);
    UIView *blurView = nil;
    NSArray *subviews = backgroundView != nil ? backgroundView.subviews : orig.subviews;
    for (UIView *view in subviews) {
        if ([view isKindOfClass:objc_getClass("_UIBackdropView")] || [view isKindOfClass:objc_getClass("CKCB7BlurView")]) {
            blurView = view;
            break;
        }
    }
    BOOL shouldOpacityBG = (isTop && opacityTopBar) || (!isTop && opacityBottomBar);
    CGFloat opacity = isTop ? topOpacity : bottomOpacity;
    if (shouldOpacityBG) {
        if (blurView)
            blurView.alpha = opacity;
        else
            orig.alpha = opacity;
    }
    BOOL shouldClearBG = (isTop && hideTopBar) || (!isTop && hideBottomBar);
    if (shouldClearBG)
        orig.backgroundColor = UIColor.clearColor;
}
