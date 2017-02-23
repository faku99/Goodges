#import "GGRootListController.h"

@interface GGRootListController ()

@end


@implementation GGRootListController

-(instancetype)init {
    self = [super init];

    if(self) {
        _prefs = [NSClassFromString(@"GGPrefsManager") sharedManager];
    }

    return self;
}

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)performRespring:(PSSpecifier *)specifier {
    system("killall -9 backboardd");
}

-(id)readPreferenceValue:(PSSpecifier *)specifier {
    return [_prefs valueForKey:[specifier propertyForKey:@"key"]] ?: [specifier propertyForKey:@"default"];
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    [_prefs setValue:value forKey:[specifier propertyForKey:@"key"]];
}

-(void)setLabelsUseCB:(id)value specifier:(PSSpecifier *)specifier {
    if([value boolValue]) {
        [_prefs setValue:@(NO) forKey:kHighlightUseCB];
    }

    [self setPreferenceValue:value specifier:specifier];

    [self reloadSpecifierID:@"highlightUseCBSpec" animated:YES];
}

-(void)setHighlightUseCB:(id)value specifier:(PSSpecifier *)specifier {
    if([value boolValue]) {
        [_prefs setValue:@(NO) forKey:kLabelsUseCB];
    }

    [self setPreferenceValue:value specifier:specifier];

    [self reloadSpecifierID:@"labelsUseCBSpec" animated:YES];
}

-(void)_returnKeyPressed:(UIKeyboard *)keyboard {
    [self.view endEditing:YES];

    [super _returnKeyPressed:keyboard];
}

@end
