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

    // draw rectangle around area being analyzed
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rectangle = CGRectMake((appDelegate.viewController.selectionX),
                                  (appDelegate.viewController.selectionY),
                                  -100 / appDelegate.widthScaleFactor,
                                  100 / appDelegate.heightScaleFactor);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}

@end
