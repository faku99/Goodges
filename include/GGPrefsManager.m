#import "common.h"
#import "GGPrefsManager.h"


@interface GGPrefsManager ()

@property (nonatomic, retain) NSDictionary *appSettings;
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

-(id)valueForKey:(NSString *)key {
    return [_userSettings objectForKey:key];
}

-(void)setValue:(id)value forKey:(NSString *)key {
    NSMutableDictionary *settings = [_userSettings mutableCopy];

    [settings setObject:value forKey:key];
    [settings writeToFile:USER_SETTINGS atomically:YES];

    NSLog(@"Writed %@ for key:%@", value, key);

    _userSettings = [settings copy];
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

    if(_userSettings == nil) {
        _userSettings = [[NSDictionary alloc] initWithContentsOfFile:DEFAULT_SETTINGS];
    }

    NSLog(@"User settings:");
    for(NSString *key in [_userSettings allKeys]) {
        NSLog(@" - %@: %@", key, [_userSettings objectForKey:key]);
    }
}

@end
