//
//  AppDelegate.h
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    CGFloat heightScaleFactor;
    CGFloat widthScaleFactor;
    int currentBoxWidth;
    int currentBoxHeight;
    int startingSelectionX;
    int startingSelectionY;
}

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) ViewController *viewController;

@property (nonatomic, readonly) CGFloat heightScaleFactor;
@property (nonatomic, readonly) CGFloat widthScaleFactor;
@property (nonatomic, assign) int currentBoxWidth;
@property (nonatomic, assign) int currentBoxHeight;
@property (nonatomic, assign) int startingSelectionX;
@property (nonatomic, assign) int startingSelectionY;

@end
