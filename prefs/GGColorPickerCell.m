#import <GGPrefsManager.h>
#import <UIColor+Goodges.h>

#import <libcolorpicker.h>
#import <Preferences/PSSpecifier.h>

#import "GGColorPickerCell.h"

@interface GGColorPickerCell ()

@property (nonatomic, retain) UIView *colorPreview;
@property (nonatomic, retain) GGPrefsManager *prefs;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier;

- (NSString *)previewColor;

- (void)displayAlert;
- (void)drawAccessoryView;
- (void)updateCellDisplay;

@end


@implementation GGColorPickerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

    if(self) {
        _prefs = [NSClassFromString(@"GGPrefsManager") sharedManager];

        [specifier setTarget:self];
        [specifier setButtonAction:@selector(displayAlert)];

        [self drawAccessoryView];
    }

    return self;
}

-(void)didMoveToSuperview {
    [super didMoveToSuperview];

    [self updateCellDisplay];
}

-(void)displayAlert {
    UIColor *startColor = [UIColor RGBAColorFromHexString:[self previewColor]];
    BOOL alpha = [[self.specifier propertyForKey:@"alpha"] boolValue];

    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:alpha];

    [alert displayWithCompletion:^void(UIColor *pickedColor) {
        NSString *hexString = [UIColor hexStringFromColor:pickedColor];

        hexString = [hexString stringByAppendingFormat:@":%.2f", pickedColor.alpha];

        [_prefs setValue:hexString forKey:[self.specifier propertyForKey:@"key"]];

        [self updateCellDisplay];
    }];
}

-(void)drawAccessoryView {
    _colorPreview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 29, 29)];

    _colorPreview.layer.cornerRadius = _colorPreview.frame.size.width / 2;
    _colorPreview.layer.borderWidth = 1;
    _colorPreview.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [self setAccessoryView:_colorPreview];
    [self updateCellDisplay];
}

-(NSString *)previewColor {
    NSString *color = [_prefs valueForKey:[self.specifier propertyForKey:@"key"]];
    NSUInteger location = [color rangeOfString:@":"].location;

    if(location != NSNotFound) {
        return [color substringWithRange:NSMakeRange(0, location)];
    }

    return color;
}

-(void)updateCellDisplay {
    _colorPreview.backgroundColor = [UIColor RGBAColorFromHexString:[self previewColor]];
    self.detailTextLabel.text = [self previewColor];
    self.detailTextLabel.alpha = 0.65;
}

-(void)dealloc {
    _colorPreview = nil;
    _prefs = nil;

    [super dealloc];
}

@end
