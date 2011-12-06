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
}

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) ViewController *viewController;

@property (nonatomic, readonly) CGFloat heightScaleFactor;
@property (nonatomic, readonly) CGFloat widthScaleFactor;

@end
