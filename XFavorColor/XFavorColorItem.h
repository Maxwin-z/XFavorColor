//
//  XFavorColorItem.h
//  XFavorColor
//
//  Created by Maxwin on 13-6-3.
//  Copyright (c) 2013年 nju. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XColor.h"

@class XFavorColorItem;
@protocol XFavorColorItemDelegate <NSObject>
- (void)favorColorItemDidSelect:(XFavorColorItem *)item;
- (void)favorColorItemDidDelete:(XFavorColorItem *)item;
@end

@interface XFavorColorItem : NSView
@property (assign, nonatomic) id<XFavorColorItemDelegate> delegate;
@property (strong, nonatomic) XColor *color;
@property (assign, nonatomic) NSInteger index;
@end
