//
//  XFavorColorItem.m
//  XFavorColor
//
//  Created by Maxwin on 13-6-3.
//  Copyright (c) 2013年 nju. All rights reserved.
//

#import "XFavorColorItem.h"

@interface XFavorColorItem ()
@property (strong, nonatomic) IBOutlet NSView *view;
@property (unsafe_unretained, nonatomic) IBOutlet NSTextField *colorLabel;
@property (unsafe_unretained, nonatomic) IBOutlet NSTextField *descLabel;
@end

@implementation XFavorColorItem

- (id)init
{
    self = [super init];
    if (self) {
        [NSBundle loadNibNamed:@"ColorItem" owner:self];
        CGRect frame = self.frame;
        frame.size = _view.bounds.size;
        self.frame = frame;
        [self addSubview:_view];
    }
    return self;
}

- (void)setColor:(XColor *)color
{
    _color = color;
    _colorLabel.backgroundColor = color.color;
    _descLabel.stringValue = color.desc;
}

- (IBAction)onUseButtonClick:(id)sender
{
    [_delegate favorColorItemDidSelect:self];
}

- (IBAction)onDelButtonClick:(id)sender
{
    [_delegate favorColorItemDidDelete:self];
}

@end
