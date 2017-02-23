#import <Social/Social.h>

#import "GGRootListController.h"

@interface GGRootListController ()

- (void)layoutLove;
- (void)paypal;
- (void)tweet;

@end


@implementation GGRootListController

-(instancetype)init {
    self = [super init];

    if(self) {
        _prefs = [NSClassFromString(@"GGPrefsManager") sharedManager];

        [self layoutLove];
    }

    return self;
}

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)performRespring {
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

-(void)layoutLove {
    UIImage *heartNorm = [UIImage imageNamed:@"images/heart" inBundle:self.bundle compatibleWithTraitCollection:nil];
    UIImage *heartHigh = [UIImage imageNamed:@"images/heart_touched" inBundle:self.bundle compatibleWithTraitCollection:nil];

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(0, 13, 22, 22)];
    [shareButton setImage:heartNorm forState:UIControlStateNormal];
    [shareButton setImage:heartHigh forState:UIControlStateHighlighted];
    [shareButton addTarget:self action:@selector(tweet) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:shareButton] autorelease];
}

-(void)paypal {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=PJPUWDWLQAJRC&lc=US&item_name=faku99%20development&item_number=Goodges&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted"]];
}

-(void)tweet {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Badges don't hurt my eyes anymore thanks to #Goodges by @faku99dev!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

@end
