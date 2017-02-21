#include <common.h>

#include "UIColor+Goodges.h"

@implementation UIColor (Goodges)

// http://stackoverflow.com/a/12397366/3238070
+(UIColor *)RGBAColorFromHexString:(NSString *)string {
    if(string.length == 0) {
        return [UIColor blackColor];
    }

    CGFloat alpha = 1.0;
    NSUInteger location = [string rangeOfString:@":"].location;
    NSString *hexString;

    if(location != NSNotFound) {
        alpha = [[string substringFromIndex:(location + 1)] floatValue];
        hexString = [string substringWithRange:NSMakeRange(0, location)];
    } else {
        hexString = [string copy];
    }

    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];

    if([hexString rangeOfString:@"#"].location == 0) {
        [scanner setScanLocation:1];
    }

    [scanner scanHexInt:&rgbValue];

    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                    green:((rgbValue & 0xFF00) >> 8) / 255.0
                    blue:(rgbValue & 0xFF) / 255.0
                    alpha:alpha];
}

+(NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
}

/*+(int)intFromColor:(UIColor *)color {
  if([color class] != [UIColor class])
    return 0;

  else {
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return (((int)(r * 255)) << 16) ^ (((int)(g * 255)) << 8) ^ ((int)(b * 255));
  }
}

-(UIColor *)inverseColor {
  CGColorRef oldCGColor = self.CGColor;

  int numberOfComponents = CGColorGetNumberOfComponents(oldCGColor);

  if (numberOfComponents == 1) {
    return [UIColor colorWithCGColor:oldCGColor];
  }

  const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
  CGFloat newComponentColors[numberOfComponents];

  int i = numberOfComponents - 1;
  newComponentColors[i] = oldComponentColors[i];
  while (--i >= 0) {
    newComponentColors[i] = 1 - oldComponentColors[i];
  }

  CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
  UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
  CGColorRelease(newCGColor);

  return newColor;
}

-(BOOL)isDarkColor {
  CGFloat colorBrightness = 0;

  CGColorSpaceRef colorSpace = CGColorGetColorSpace(self.CGColor);
  CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpace);

  if(colorSpaceModel == kCGColorSpaceModelRGB){
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
  } else {
    [self getWhite:&colorBrightness alpha:0];
  }

  return (colorBrightness < 0.8);
}*/

@end
