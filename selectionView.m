//
//  selectionView.m
//  ColourDetector
//
//  Created by TODD STEINACKLE on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "selectionView.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation selectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    // the pixel buffer gives the height and width in landscape
    // it's swapped here since this view's coordinates are in portrait
    pictureWidth = appDelegate.viewController.pixelBufferHeight;
    pictureHeight = appDelegate.viewController.pixelBufferWidth;
#ifdef DEBUG
    NSLog(@"picture width - %d", pictureWidth);
    NSLog(@"picture height - %d", pictureHeight);
#endif
    heightScaleFactor = pictureHeight/480.0;
    widthScaleFactor = pictureWidth/320.0;
#ifdef DEBUG
    NSLog(@"heightScaleFactor - %f", heightScaleFactor);
    NSLog(@"widthScaleFactor - %f", widthScaleFactor);
#endif
    // draw rectangle around area being analyzed
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rectangle = CGRectMake((320/2 - 50 / widthScaleFactor),
                                  (480/2 - 50 / heightScaleFactor),
                                  100 / widthScaleFactor,
                                  100 / heightScaleFactor);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}


@end
