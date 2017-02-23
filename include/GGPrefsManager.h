#define APP_SETTINGS        @"/var/mobile/Library/Application Support/Goodges/AppSettings.plist"
#define DEFAULT_SETTINGS    @"/var/mobile/Library/Application Support/Goodges/DefaultSettings.plist"
#define USER_SETTINGS       @"/var/mobile/Library/Application Support/Goodges/UserSettings.plist"

// Settings constants
#define kEnabled            @"isEnabled"

#define kHideAllLabels      @"hideAllLabels"

#define kEnableLabels       @"enableLabels"
#define kLabelsColor        @"labelsColor"
#define kLabelsUseCB        @"labelsUseCB"

#define kEnableHighlight    @"enableHighlight"
#define kHighlightColor     @"highlightColor"
#define kHighlightUseCB     @"highlightUseCB"

#define kEnableGlow         @"enableGlow"

#define kEnableShaking      @"enableShaking"

@interface GGPrefsManager : NSObject

+ (instancetype)sharedManager;

- (instancetype)init;

- (BOOL)boolForKey:(NSString *)key;

- (NSInteger)intForKey:(NSString *)key;

- (id)valueForKey:(NSString *)key;
- (id)valueForKey:(NSString *)key forDisplayIdentifier:(NSString *)displayIdentifier;

- (void)setValue:(id)value forKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key forDisplayIdentifier:(NSString *)displayIdentifier;

@end
