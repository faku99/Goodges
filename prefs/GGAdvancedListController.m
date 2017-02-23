#import <GGPrefsManager.h>

#import "GGAdvancedListController.h"

@interface GGAdvancedListController ()

- (void)eraseSettings;
- (void)exportSettings;

@end


@implementation GGAdvancedListController

-(NSArray *)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"Advanced" target:self] retain];
    }

    return _specifiers;
}

-(void)eraseSettings {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Do you want to erase all your Goodges settings?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:APP_SETTINGS error:nil];
        [manager removeItemAtPath:USER_SETTINGS error:nil];

        [self performRespring];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];

    [alert addAction:noAction];
    [alert addAction:yesAction];

    [self presentViewController:alert animated:YES completion:nil];
}

-(void)exportSettings {
    NSString *title = @"Goodges settings";
    NSString *message = @"To import settings into Goodges, please copy those file at the following path: \"/User/Library/Application Support/Goodges/\"";

    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    vc.mailComposeDelegate = self;

    [vc setSubject:title];
    [vc setMessageBody:message isHTML:NO];

    NSData *appsData = [NSData dataWithContentsOfFile:APP_SETTINGS];
    NSData *userData = [NSData dataWithContentsOfFile:USER_SETTINGS];

    if(appsData == nil) {
        appsData = [NSData dataWithContentsOfFile:DEFAULT_APP_SETTINGS];
    }

    if(userData == nil) {
        userData = [NSData dataWithContentsOfFile:DEFAULT_USER_SETTINGS];
    }

    [vc addAttachmentData:appsData mimeType:@"application/xml" fileName:@"AppSettings.plist"];
    [vc addAttachmentData:userData mimeType:@"application/xml" fileName:@"UserSettings.plist"];

    [self presentViewController:vc animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
