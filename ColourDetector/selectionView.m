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
    if (self)
    {
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
    UIColor *color;
    if (appDelegate.viewController.locked)
    {
        color = [UIColor redColor];
    }
    else
    {
        color = [UIColor greenColor];
    }
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    if(appDelegate.currentBoxHeight >= appDelegate.SCREEN_HEIGHT_IN_POINTS)
        appDelegate.currentBoxHeight = 50;
    if(appDelegate.currentBoxWidth >= appDelegate.SCREEN_WIDTH_IN_POINTS)
        appDelegate.currentBoxWidth = 50;
    CGRect rectangle = CGRectMake((appDelegate.viewController.selectionX),
                              (appDelegate.viewController.selectionY),
                              -appDelegate.currentBoxWidth / appDelegate.viewController.widthScaleFactor,
                              appDelegate.currentBoxHeight / appDelegate.viewController.heightScaleFactor);
    
    //only draw above rectangle if in rectangular selection mode
    if(!appDelegate.circleDraw)
    {
        CGContextAddRect(context, rectangle);
        CGContextStrokePath(context);
        UIColor *outlineColor = [UIColor whiteColor];
        CGContextSetStrokeColorWithColor(context, outlineColor.CGColor);
        CGContextSetLineWidth(context, 1.0);
    }

    CGRect outlineRect = CGRectMake((appDelegate.viewController.selectionX + (2 / appDelegate.viewController.widthScaleFactor)),
                                (appDelegate.viewController.selectionY - (2 / appDelegate.viewController.heightScaleFactor)),
                                (-appDelegate.currentBoxWidth - (4 / appDelegate.viewController.widthScaleFactor)) / appDelegate.viewController.widthScaleFactor,
                                (appDelegate.currentBoxHeight + (4 / appDelegate.viewController.heightScaleFactor)) / appDelegate.viewController.heightScaleFactor);
    
    //if in circle selection mode then draw an ellipse inside the selection rectangle
    if(appDelegate.circleDraw)
    {
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
    }
    
    //add outline rectangle if in rectangular selection mode
    else
    {
        CGContextAddRect(context, outlineRect);
        CGContextStrokePath(context);
    }
}

@end
