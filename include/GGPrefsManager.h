// Bundle path.
#define BUNDLE_PATH             @"/Library/PreferenceBundles/GoodgesPrefs.bundle"

// Settings files.
#define APP_SETTINGS            @"/var/mobile/Library/Application Support/Goodges/AppSettings.plist"
#define DEFAULT_APP_SETTINGS    @"/Library/Application Support/Goodges/DefaultAppSettings.plist"
#define DEFAULT_USER_SETTINGS   @"/Library/Application Support/Goodges/DefaultUserSettings.plist"
#define SETTINGS_PATH           @"/var/mobile/Library/Application Support/Goodges"
#define USER_SETTINGS           @"/var/mobile/Library/Application Support/Goodges/UserSettings.plist"

// Settings constants
#define kEnabled                @"isEnabled"

#define kHideAllLabels          @"hideAllLabels"
#define kHideBadges             @"hideBadges"

#define kShowOnlyNumbers        @"showOnlyNumbers"
#define kCapitalizeFirstLetter  @"capitalizeFirstLetter"
#define kEnableLabels           @"enableLabels"
#define kLabelsColor            @"labelsColor"
#define kInverseColor           @"inverseColor"
#define kLabelsUseCB            @"labelsUseCB"

#define kEnableHighlight        @"enableHighlight"
#define kHighlightColor         @"highlightColor"
#define kHighlightUseCB         @"highlightUseCB"

#define kEnableGlow             @"enableGlow"

#define kEnableShaking          @"enableShaking"

#define kSingularLabel          @"sLabel"
#define kPluralLabel            @"pLabel"

#define kDefaultNotification    @"NOTIFICATION"
#define kDefaultNotifications   @"NOTIFICATIONS"


@interface GGPrefsManager : NSObject

+ (instancetype)sharedManager;

- (instancetype)init;

- (BOOL)appIsEnabledForDisplayIdentifier:(NSString *)displayIdentifier;
- (BOOL)boolForKey:(NSString *)key;

- (NSInteger)intForKey:(NSString *)key;

- (NSString *)localizedStringForKey:(NSString *)key;

- (id)valueForKey:(NSString *)key;
- (id)valueForKey:(NSString *)key forDisplayIdentifier:(NSString *)displayIdentifier;

- (void)setValue:(id)value forKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key forDisplayIdentifier:(NSString *)displayIdentifier;

@end
