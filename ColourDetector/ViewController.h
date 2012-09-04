//
//  ViewController.h
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "OutputsViewController.h"
#import "SettingsViewController.h"

@class selectionView;
@class AppDelegate;

@interface ViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate> {
    AVCaptureSession *session;
    NSTimer *updateTimer;
    UIView *previewView;
    float r,g,b;  // red, green, blue
    float h,s,v;  // hue, saturation, value

    AppDelegate *appDelegate;
    BOOL captureImage;
    BOOL running;
    BOOL locked;
    BOOL uiHidden;
    BOOL buttonsVisible;
    int pixelBufferWidth;
    int pixelBufferHeight;
    // the starting points for where the rectangle will be drawn
    CGFloat selectionX;
    CGFloat selectionXimage;
    CGFloat selectionY;
    int pixelStartX;
    int pixelStartY;
    OutputsViewController *outputsViewController;
    SettingsViewController *settingsViewController;
}

- (IBAction)captureImage;
- (IBAction)showSettingsView;
- (IBAction)showOutputsView:(UIButton*)sender;
- (void)checkTargets;
- (IBAction)startStop;
- (IBAction)lockUnlock;
- (IBAction)hideUI;
- (IBAction)showOutputButtons;
- (void)drawSelectionRectToSavedImage;
- (void)updateIndicator:(int)target :(UIColor *)color;
- (void)reportFocus:(int)focusMode;
- (void)reportExposure:(int)exposureMode;

@property (nonatomic, retain) IBOutlet UIView *previewView;
@property (nonatomic, retain) IBOutlet UIView *selectionView;
@property (retain, nonatomic) IBOutlet UIView *rgbColourView;
@property (retain, nonatomic) IBOutlet UILabel *infoLabel;
@property (retain, nonatomic) IBOutlet UILabel *rgbLabel;
@property (retain, nonatomic) IBOutlet UILabel *hueLabel;
@property (retain, nonatomic) IBOutlet UILabel *topLable;
@property (retain, nonatomic) IBOutlet UIButton *runButton;
@property (retain, nonatomic) IBOutlet UIButton *lockButton;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;
@property (retain, nonatomic) IBOutlet UIButton *settingsButton;
@property (retain, nonatomic) IBOutlet UIButton *outputsButton;
@property (retain, nonatomic) IBOutlet UIButton *output1;
@property (retain, nonatomic) IBOutlet UIButton *output2;
@property (retain, nonatomic) IBOutlet UIButton *output3;
@property (retain, nonatomic) IBOutlet UIButton *output4;
@property (retain, nonatomic) IBOutlet UIButton *output5;
@property (retain, nonatomic) IBOutlet UIButton *output6;
@property (retain, nonatomic) IBOutlet UIButton *output7;
@property (retain, nonatomic) IBOutlet UIButton *output8;
@property (retain, nonatomic) IBOutlet UIButton *outputButton1;
@property (retain, nonatomic) IBOutlet UIButton *outputButton2;
@property (retain, nonatomic) IBOutlet UIButton *outputButton3;
@property (retain, nonatomic) IBOutlet UIButton *outputButton4;
@property (retain, nonatomic) IBOutlet UIButton *outputButton5;
@property (retain, nonatomic) IBOutlet UIButton *outputButton6;
@property (retain, nonatomic) IBOutlet UIButton *outputButton7;
@property (retain, nonatomic) IBOutlet UIButton *outputButton8;
@property (nonatomic, readonly) int pixelBufferWidth;
@property (nonatomic, readonly) int pixelBufferHeight;
@property (nonatomic, assign) CGFloat selectionX;
@property (nonatomic, assign) CGFloat selectionXimage;
@property (nonatomic, assign) CGFloat selectionY;
@property (nonatomic, retain) OutputsViewController *outputsViewController;
@property (nonatomic, retain) SettingsViewController *settingsViewController;
@property (nonatomic, readonly) BOOL locked;
@property (nonatomic, assign) BOOL isExposureLockSupported;
@property (nonatomic, assign) BOOL isFocusLockSupported;
@property (nonatomic, assign) int outputScreen;

@end
