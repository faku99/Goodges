#import <GGPrefsManager.h>

#import <Preferences/PSSpecifier.h>

#import "GGDeveloperCell.h"

@interface GGDeveloperCell ()

@property (nonatomic, retain) NSBundle *bundle;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier;

- (void)openTwitter;

@end


@implementation GGDeveloperCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

    if(self) {
        _bundle = [NSBundle bundleWithPath:BUNDLE_PATH];
        [_bundle load];

        // Labels
        self.textLabel.text = @"faku99";
        self.detailTextLabel.text = @"@faku99dev";
        self.detailTextLabel.textColor = [UIColor grayColor];

        // Right image
        UIImage *twitterLogo = [UIImage imageNamed:@"images/twitter" inBundle:_bundle compatibleWithTraitCollection:nil];
        self.accessoryView = [[[UIImageView alloc] initWithImage:twitterLogo] autorelease];

        [specifier setTarget:self];
        [specifier setButtonAction:@selector(openTwitter)];
    }

    return self;
}

-(void)openTwitter {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/faku99dev"]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=faku99dev"]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=faku99dev"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/faku99dev"]];
    }
}

@end
