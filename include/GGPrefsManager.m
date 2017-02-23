#import "common.h"
#import "GGPrefsManager.h"


@interface GGPrefsManager ()

@property (nonatomic, retain) NSDictionary *appSettings;
@property (nonatomic, retain) NSBundle *bundle;
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

-(BOOL)boolForKey:(NSString *)key {
    return [[_userSettings objectForKey:key] boolValue];
}

-(NSInteger)intForKey:(NSString *)key {
    return [[_userSettings objectForKey:key] intValue];
}

-(NSString *)localizedStringForKey:(NSString *)key {
    return [_bundle localizedStringForKey:key value:key table:nil];
}

-(id)valueForKey:(NSString *)key {
    return [_userSettings objectForKey:key];
}

-(id)valueForKey:(NSString *)key forDisplayIdentifier:(NSString *)displayIdentifier {
    return [[_appSettings objectForKey:displayIdentifier] objectForKey:key] ?: nil;
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
    _appSettings = nil;
    _userSettings = nil;

    [super dealloc];
}

#pragma mark - Private methods

-(void)loadPreferences {
    _appSettings = [[NSDictionary alloc] initWithContentsOfFile:APP_SETTINGS];
    _userSettings = [[NSDictionary alloc] initWithContentsOfFile:USER_SETTINGS];

    if(_appSettings == nil) {
        _appSettings = [[NSDictionary alloc] initWithContentsOfFile:DEFAULT_APP_SETTINGS];
    }

    if(_userSettings == nil) {
        _userSettings = [[NSDictionary alloc] initWithContentsOfFile:DEFAULT_USER_SETTINGS];
    }

    // For debugging purposes.
    NSLog(@"User settings:");
    for(NSString *key in [_userSettings allKeys]) {
        NSLog(@" - %@: %@", key, [_userSettings objectForKey:key]);
    }

    NSLog(@"Apps settings:");
    for(NSString *key in [_appSettings allKeys]) {
        NSLog(@" - %@", key);
        NSDictionary *appSettings = [_appSettings objectForKey:key];
        for(NSString *appKey in [appSettings allKeys]) {
            NSLog(@" %@: %@", appKey, [appSettings objectForKey:appKey]);
        }
    }
}

@end
