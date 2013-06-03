//
//  XColor.h
//  XFavorColor
//
//  Created by Maxwin on 13-6-3.
//  Copyright (c) 2013年 nju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XColor : NSObject <NSCoding>
@property (strong, nonatomic) NSString *colorString;
@property (strong, nonatomic) NSString *desc;

@property (strong, nonatomic, readonly) NSColor *color;

+ (NSString *)color2string:(NSColor *)color;
+ (NSColor *)string2color:(NSString *)string;

@end
