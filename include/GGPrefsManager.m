#import "GGPrefsManager.h"

@interface GGPrefsManager ()

@property (nonatomic, retain) NSDictionary *appSettings;
@property (nonatomic, retain) NSBundle *bundle;
@property (nonatomic, retain) NSDictionary *defaultAppSettings;
@property (nonatomic, retain) NSDictionary *defaultUserSettings;
@property (nonatomic, retain) NSDictionary *userSettings;

@end


static GGPrefsManager *sharedInstance = nil;


@implementation GGPrefsManager

+(instancetype)sharedManager {
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }

    return sharedInstance;
}

-(instancetype)init {
    self = [super init];

    if(self) {
        _bundle = [NSBundle bundleWithPath:BUNDLE_PATH];
        [_bundle load];
        if(_bundle == nil) {
            HBLogError(@"Preference bundle not found!");
        }

        [self loadPreferences];
    }

    return self;
}

-(BOOL)appIsEnabledForDisplayIdentifier:(NSString *)displayIdentifier {
    id appEnabled = [self valueForKey:kEnabled forDisplayIdentifier:displayIdentifier];

    // If no settings exist for the app, we assume that it's enabled.
    if(appEnabled == nil) {
        appEnabled = @(YES);
    }

    return [appEnabled boolValue];
}

-(BOOL)boolForKey:(NSString *)key {
    id ret = [_userSettings objectForKey:key];

    if(ret == nil) {
        ret = [_defaultUserSettings objectForKey:key];
    }

    return [ret boolValue];
}

-(NSString *)localizedStringForKey:(NSString *)key {
    return [_bundle localizedStringForKey:key value:key table:nil];
}

-(id)valueForKey:(NSString *)key {
    return [_userSettings objectForKey:key] ?: [_defaultUserSettings objectForKey:key];
}

-(id)valueForKey:(NSString *)key forDisplayIdentifier:(NSString *)displayIdentifier {
    return [[_appSettings objectForKey:displayIdentifier] objectForKey:key] ?: [[_defaultAppSettings objectForKey:displayIdentifier] objectForKey:key];
}

-(void)setValue:(id)value forKey:(NSString *)key {
    NSMutableDictionary *settings = [_userSettings mutableCopy];

    [settings setObject:value forKey:key];
    [settings writeToFile:USER_SETTINGS atomically:YES];

    _userSettings = [settings copy];
}

-(void)setValue:(id)value forKey:(NSString *)key forDisplayIdentifier:(NSString *)displayIdentifier {
    NSMutableDictionary *settings = [_appSettings mutableCopy];

    NSMutableDictionary *appSettings = [[_appSettings objectForKey:displayIdentifier] mutableCopy];
    if(appSettings == nil) {
        appSettings = [[NSMutableDictionary alloc] init];
    }
    [appSettings setObject:value forKey:key];

    [settings setObject:appSettings forKey:displayIdentifier];
    [settings writeToFile:APP_SETTINGS atomically:YES];

    _appSettings = [settings copy];
}

-(void)dealloc {
    [_appSettings release];
    [_defaultAppSettings release];
    [_defaultUserSettings release];
    [_userSettings release];

    _appSettings = nil;
    _defaultAppSettings = nil;
    _defaultUserSettings = nil;
    _userSettings = nil;

    [super dealloc];
}

#pragma mark - Private methods

-(void)loadPreferences {
    _appSettings = [[NSDictionary alloc] initWithContentsOfFile:APP_SETTINGS];
    _defaultAppSettings = [[NSDictionary alloc] initWithContentsOfFile:DEFAULT_APP_SETTINGS];
    _defaultUserSettings = [[NSDictionary alloc] initWithContentsOfFile:DEFAULT_USER_SETTINGS];
    _userSettings = [[NSDictionary alloc] initWithContentsOfFile:USER_SETTINGS];

    NSFileManager *manager = [NSFileManager defaultManager];

    if(![manager fileExistsAtPath:SETTINGS_PATH isDirectory:nil]) {
        if(![manager createDirectoryAtPath:SETTINGS_PATH withIntermediateDirectories:YES attributes:nil error:nil]) {
            HBLogError(@"Error creating folder...");
        }
    }

    if(_appSettings == nil) {
        _appSettings = [_defaultAppSettings copy];
    }

    if(_userSettings == nil) {
        _userSettings = [_defaultUserSettings copy];
    }
}

@end
