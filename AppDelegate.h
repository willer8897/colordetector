//
//  AppDelegate.h
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CGFloat SCREEN_WIDTH_IN_POINTS;
    CGFloat SCREEN_HEIGHT_IN_POINTS;
    int currentBoxWidth;
    int currentBoxHeight;
    int startingSelectionX;
    int startingSelectionY;
    NSString *fileName;
    NSMutableDictionary *settings;
    NSString *settingsFilePath;
    NSString *arrayFilePath;
    NSMutableArray *targets;
}

- (void)loadFileSettings:(NSString *)saveName;
- (void)saveSettings;
- (void)saveAsSettings:(NSString *)saveName;
- (void)initSettingsFilePath;
- (NSArray*)getFileNames;

- (void)loadTargets;
- (void)saveTargets;
- (void)updateTargets:(NSArray *)sortedArray :(int)target :(BOOL)enabled :(BOOL)lightEnabled :(int)NormOpenClosed :(float)onDelay :(float)offDelay;

- (void)setStartingCoordinates;

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) ViewController *viewController;

@property (nonatomic, assign) int currentBoxWidth;
@property (nonatomic, assign) int currentBoxHeight;
@property (nonatomic) BOOL circleDraw;
@property (nonatomic) int minorAxis;
@property (nonatomic) int majorAxis;
@property (nonatomic, assign) int startingSelectionX;
@property (nonatomic, assign) int startingSelectionY;
@property (nonatomic, assign) BOOL exposureLock;
@property (nonatomic, assign) BOOL focusLock;
@property (nonatomic, assign) CGRect screenRect;
@property (nonatomic, retain) NSString *fileName;

@property (nonatomic, readonly) CGFloat SCREEN_WIDTH_IN_POINTS;
@property (nonatomic, readonly) CGFloat SCREEN_HEIGHT_IN_POINTS;

@property (retain, nonatomic) NSMutableArray *targets;

@end
