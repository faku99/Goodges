#import <AppList/AppList.h>

#import "GGAppDetailsViewController.h"

@interface GGAppDetailsViewController ()

@property (nonatomic, retain) ALApplicationList *appList;

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
    self.title = [_appList valueForKey:@"displayName" forDisplayIdentifier:[self.specifier name]];

    [super viewWillAppear:animated];
}

@end
