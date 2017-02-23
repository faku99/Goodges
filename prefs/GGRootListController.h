#import <GGPrefsManager.h>

#import <Preferences/PSListController.h>

@interface GGRootListController : PSListController

@property (nonatomic, retain) GGPrefsManager *prefs;

- (void)performRespring:(PSSpecifier *)specifier;

@end
