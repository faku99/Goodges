#import <AppList/AppList.h>

#import "GGAppDetailsViewController.h"

@interface GGAppDetailsViewController ()

@property (nonatomic, retain) ALApplicationList *appList;
@property (nonatomic, retain) NSString *displayIdentifier;

@end


@implementation GGAppDetailsViewController

-(NSArray *)specifiers {
    if (_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"PerApp" target:self] retain];
    }

    return _specifiers;
}

-(void)viewWillAppear:(BOOL)animated {
    _appList = [ALApplicationList sharedApplicationList];
    _displayIdentifier = [[self specifier] name];
    self.title = [_appList valueForKey:@"displayName" forDisplayIdentifier:_displayIdentifier];

    [super viewWillAppear:animated];
}

-(NSString *)getLocalizedString:(PSSpecifier *)specifier {
    return [self.prefs localizedStringForKey:[self readPreferenceValue:specifier]];
}

-(id)readPreferenceValue:(PSSpecifier *)specifier {
    return [self.prefs valueForKey:[specifier propertyForKey:@"key"] forDisplayIdentifier:_displayIdentifier] ?: [specifier propertyForKey:@"default"];
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    [self.prefs setValue:value forKey:[specifier propertyForKey:@"key"] forDisplayIdentifier:_displayIdentifier];
}

@end
