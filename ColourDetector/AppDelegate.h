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
    CGFloat SCREEN_WIDTH_IN_POINTS;
    CGFloat SCREEN_HEIGHT_IN_POINTS;
    int currentBoxWidth;
    int currentBoxHeight;
    int startingSelectionX;
    int startingSelectionY;
    NSMutableDictionary *settings;
    NSString *settingsFilePath;
    NSMutableArray *targets;
}

- (void)loadSettings;
- (void)saveSettings;
- (void)initSettingsFilePath;

- (void)loadTargets;
- (void)saveTargets;
- (void)updateTargets:(NSArray *)sortedArray :(int)target :(BOOL)enabled :(BOOL)lightEnabled :(int)NormOpenClosed :(float)onDelay :(float)offDelay;

- (void)setStartingCoordinates;

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) ViewController *viewController;

@property (nonatomic, readonly) CGFloat heightScaleFactor;
@property (nonatomic, readonly) CGFloat widthScaleFactor;
@property (nonatomic, assign) int currentBoxWidth;
@property (nonatomic, assign) int currentBoxHeight;
@property (nonatomic, assign) int startingSelectionX;
@property (nonatomic, assign) int startingSelectionY;
@property (nonatomic, assign) BOOL exposureLock;
@property (nonatomic, assign) BOOL focusLock;

@property (nonatomic, readonly) CGFloat SCREEN_WIDTH_IN_POINTS;
@property (nonatomic, readonly) CGFloat SCREEN_HEIGHT_IN_POINTS;

@property (retain, nonatomic) NSMutableArray *targets;

@end
