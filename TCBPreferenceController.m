#define KILL_PROCESS
#define UIFUNCTIONS_NOT_C
#import <UIKit/UIKit.h>
#import <Cephei/HBListController.h>
#import <Cephei/HBAppearanceSettings.h>
#import <Preferences/PSSpecifier.h>
#import <Social/Social.h>
#import <UIKit/UIImage+Private.h>
#import <UIKit/UIColor+Private.h>
#import <dlfcn.h>
#import "Prefs.h"

@interface TCBPreferenceController : HBListController
@property(retain, nonatomic) PSSpecifier *fsSpec;
@property(retain, nonatomic) PSSpecifier *fs2Spec;
@end

@implementation TCBPreferenceController

HavePrefs()

- (void)masterSwitch:(id)value specifier:(PSSpecifier *)spec {
    [self setPreferenceValue:value specifier:spec];
    killProcess("Camera");
}

HaveBanner2(@"TCB", isiOS7Up ? UIColor.systemBlueColor : UIColor.blueColor, @"Camera bars, in the better way", isiOS7Up ? UIColor.systemBlueColor : UIColor.blueColor)

- (id)init {
    if (self == [super init]) {
        if (isiOS6Up) {
            if (isiOS7Up) {
                HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
                appearanceSettings.tintColor = UIColor.systemBlueColor;
                appearanceSettings.tableViewCellTextColor = UIColor.systemBlueColor;
                appearanceSettings.invertedNavigationBar = YES;
                self.hb_appearanceSettings = appearanceSettings;
            }
            UIButton *heart = [[[UIButton alloc] initWithFrame:CGRectZero] autorelease];
            UIImage *image = [UIImage imageNamed:@"Heart" inBundle:[NSBundle bundleWithPath:realPath(@"/Library/PreferenceBundles/TransparentCameraBarSettings.bundle")]];
            if (isiOS7Up)
                image = [image _flatImageWithColor:UIColor.whiteColor];
            [heart setImage:image forState:UIControlStateNormal];
            [heart sizeToFit];
            [heart addTarget:self action:@selector(love) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:heart] autorelease];
        }
    }
    return self;
}

- (void)love {
    SLComposeViewController *twitter = [[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter] retain];
    twitter.initialText = @"#TransparentCameraBar by @PoomSmart is really awesome!";
    [self.navigationController presentViewController:twitter animated:YES completion:nil];
    [twitter release];
}

- (NSArray *)specifiers {
    if (_specifiers == nil) {
        NSMutableArray *specs = [NSMutableArray arrayWithArray:[[self loadSpecifiersFromPlistName:@"TransparentCameraBar" target:self] retain]];
        BOOL noFrontFlash = NO;
        if (IS_IPAD)
            noFrontFlash = [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/FrontFlash.dylib"];
        BOOL shouldDeletePad = IS_IPAD && (noFrontFlash || !isiOS7Up);
        BOOL shouldDeletePhone = !IS_IPAD && !isiOS7Up;
        NSMutableArray *indexesToDelete = [NSMutableArray array];
        NSMutableArray *compactDelete = [NSMutableArray array];
        for (PSSpecifier *spec in specs) {
            NSString *Id = [spec identifier];
            if ([Id hasPrefix:@"topBar"])
                [indexesToDelete addObject:spec];
            else if ([Id isEqualToString:@"compactBottomBar"])
                [compactDelete addObject:spec];
            else if ([Id isEqualToString:@"fs"])
                self.fsSpec = spec;
            else if ([Id isEqualToString:@"fs2"])
                self.fs2Spec = spec;
        }
        if (IS_IPAD && compactDelete.count) {
            for (PSSpecifier *deleteSpec in compactDelete)
                [specs removeObject:deleteSpec];
        }
        if ((shouldDeletePad || shouldDeletePhone) && indexesToDelete.count) {
            for (PSSpecifier *deleteSpec in indexesToDelete)
                [specs removeObject:deleteSpec];
        }
        _specifiers = specs.copy;
    }
    return _specifiers;
}

@end
