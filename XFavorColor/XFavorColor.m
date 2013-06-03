//
//  XFavorColor.m
//  XFavorColor
//
//  Created by Maxwin on 13-6-3.
//  Copyright (c) 2013年 nju. All rights reserved.
//

#import "XFavorColor.h"
#import "XColor.h"
#import "XFavorColorItem.h"
#import <QuartzCore/CALayer.h>

#define XFAVORCOLOR_COLORS  @"colors"

@interface XFavorColor ()<NSTextFieldDelegate, XFavorColorItemDelegate>
@property (strong, nonatomic) IBOutlet NSView *panel;
@property (unsafe_unretained, nonatomic) IBOutlet NSTextField *colorTextField;
@property (unsafe_unretained, nonatomic) IBOutlet NSTextField *descTextField;
@property (unsafe_unretained, nonatomic) IBOutlet NSButton *addButton;
@property (unsafe_unretained, nonatomic) IBOutlet NSView *containerView;

@property (strong, nonatomic) NSMutableArray *colors;   // <XColor>

@end

@implementation XFavorColor

- (NSImage*)provideNewButtonImage
{
	NSImage* image;
	image = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"icon" ofType:@"png"]];
    return image;
}

#pragma mark - NSColorPickingCustom
- (BOOL)supportsMode:(NSColorPanelMode)mode
{
    switch (mode)
	{
		case NSColorPanelAllModesMask:	// we support all modes
			return YES;
	}
	return NO;
}

/* Return the current mode that your picker is in.
 */
- (NSColorPanelMode)currentMode
{
    return NSColorPanelAllModesMask;
}

/* Provide the view for your picker. initialRequest will be YES on very first call. At this point, you should load your nibs.
 */
- (NSView *)provideNewView:(BOOL)initialRequest
{
    if (initialRequest) {
        [NSBundle loadNibNamed:@"ColorPanel" owner:self];
    }
    [self setup];
    return _panel;
}

/* Set your color picker's displayed color to newColor.
 */
- (void)setColor:(NSColor *)newColor
{
    NSLog(@"%@", newColor);
}

#pragma mark - methods
- (void)setup
{
    [_colorTextField setDelegate:self];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    _colors = [[NSKeyedUnarchiver unarchiveObjectWithData:[def objectForKey:XFAVORCOLOR_COLORS]] mutableCopy];
    if (_colors == nil) {
        _colors = [[NSMutableArray alloc] init];
    }
    [self reloadColors];
    
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.2)]; //RGB plus Alpha Channel
    [_containerView setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [_containerView setLayer:viewLayer];
}

- (void)removeColorAtIndex:(NSInteger)index
{
    if (index >= 0 && index < _colors.count) {
        [_colors removeObjectAtIndex:index];
    }
    [self reloadColors];
}

- (void)reloadColors
{

    for (int i = (int)self.containerView.subviews.count - 1; i >= 0; --i) {
        NSView *v = self.containerView.subviews[i];
        [v removeFromSuperview];
    }

    CGFloat y = 50.0f;
    CGFloat padding = 5.0f;
    for (int i = 0; i != _colors.count; ++i) {
        XFavorColorItem *item = [[XFavorColorItem alloc] init];
        item.color = _colors[i];
        item.index = i;
        item.delegate = self;
        CGRect frame = item.frame;
        frame.origin.y = y;
        item.frame = frame;
        [self.containerView addSubview:item];
        y += frame.size.height + padding;
    }
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:_colors] forKey:XFAVORCOLOR_COLORS];
}

#pragma mark - Events
- (IBAction)onAddButtonClick:(id)sender
{
    XColor *c = [[XColor alloc] init];
    c.colorString = _colorTextField.stringValue;
    c.desc = _descTextField.stringValue;
    [_colors addObject:c];
    [self reloadColors];
}

- (void)controlTextDidChange:(NSNotification *)n
{
    
}

#pragma mark - XFavorColorItemDelegate
- (void)favorColorItemDidSelect:(XFavorColorItem *)item
{
    self.colorPanel.color = item.color.color;
}

- (void)favorColorItemDidDelete:(XFavorColorItem *)item
{
    [self removeColorAtIndex:item.index];
}

@end
