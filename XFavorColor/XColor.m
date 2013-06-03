//
//  XColor.m
//  XFavorColor
//
//  Created by Maxwin on 13-6-3.
//  Copyright (c) 2013年 nju. All rights reserved.
//

#import "XColor.h"

@implementation XColor

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_colorString forKey:@"colorString"];
    [aCoder encodeObject:_desc forKey:@"desc"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.colorString = [aDecoder decodeObjectForKey:@"colorString"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
    }
    return self;
}


- (NSColor *)color
{
    return [XColor string2color:_colorString];
}

+ (NSString *)color2string:(NSColor *)color
{
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [NSString stringWithFormat:@"#%2x%2x%2x%2x", (int)(r * 0xff), (int)(g * 0xff), (int)(b * 0xff), (int)(a * 0xff)];
}

+ (NSColor *)string2color:(NSString *)string
{
    NSColor* result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte, alphaByte;
    
    string = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if (nil != string)
    {
        NSScanner* scanner = [NSScanner scannerWithString:string];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char)(colorCode >> 24);
    greenByte = (unsigned char)(colorCode >> 16);
    blueByte = (unsigned char)(colorCode >> 8); // masks off high bits
    alphaByte = (unsigned char)(colorCode);
    
    result = [NSColor
              colorWithCalibratedRed:(CGFloat)redByte / 0xff
              green:(CGFloat)greenByte / 0xff
              blue:(CGFloat)blueByte / 0xff
              alpha:alphaByte/0xff];
    return result;
}

@end
