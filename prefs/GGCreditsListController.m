#import "GGCreditsListController.h"

@interface GGCreditsListController ()

@end


@implementation GGCreditsListController

-(NSArray *)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"Credits" target:self] retain];
    }

    return _specifiers;
}

@end
