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

@class selectionView;
@class AppDelegate;

@interface ViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate, UITextFieldDelegate> {
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
    BOOL settingsControlsVisible;
    // flags for exposure and focus settings in case the user dismisses the settings screen without saving
    BOOL changeExposure, changeFocus;
    int pixelBufferWidth;
    int pixelBufferHeight;
    // the starting points for where the rectangle will be drawn
    CGFloat selectionX;
    CGFloat selectionXimage;
    CGFloat selectionY;
    int pixelStartX;
    int pixelStartY;
    OutputsViewController *outputsViewController;

    NSString *selectionWidth;
    NSString *selectionHeight;
    NSString *startingX;
    NSString *startingY;

    CGFloat heightScaleFactor;
    CGFloat widthScaleFactor;
}

- (IBAction)captureImage;
- (IBAction)showSettingsControls;
- (IBAction)showOutputsView:(UIButton*)sender;
- (void)checkTargets;
- (IBAction)startStop;
- (IBAction)lockUnlock;
- (IBAction)hideUI;
- (IBAction)showOutputButtons;
- (void)drawSelectionRectToSavedImage;
- (void)updateIndicator:(int)target :(UIImage *)largeIndictator :(UIImage *)smallIndicator;
- (void)reportFocus:(int)focusMode;
- (void)reportExposure:(int)exposureMode;
- (IBAction)exposureLockChanged:(UISwitch*)sender;
- (IBAction)focusLockChanged:(UISwitch*)sender;
- (IBAction)saveSettings:(UIButton*)sender;

@property (retain, nonatomic) IBOutlet UIButton *saveSettings;
@property (retain, nonatomic) IBOutlet UITextField *selectionWidthTextField;
@property (retain, nonatomic) IBOutlet UITextField *selectionHeightTextField;
@property (retain, nonatomic) IBOutlet UITextField *startingXTextField;
@property (retain, nonatomic) IBOutlet UITextField *startingYTextField;
@property (retain, nonatomic) IBOutlet UISwitch *exposureLock;
@property (retain, nonatomic) IBOutlet UISwitch *focusLock;
@property (nonatomic, copy) NSString *selectionWidth;
@property (nonatomic, copy) NSString *selectionHeight;
@property (nonatomic, copy) NSString *startingX;
@property (nonatomic, copy) NSString *startingY;
@property (nonatomic, retain) IBOutletCollection(UIImageView) NSArray *settingControlsBackgrounds;
@property (nonatomic, retain) IBOutletCollection(UILabel) NSArray *settingControlsLabels;
@property (nonatomic, retain) IBOutlet UIView *previewView;
@property (nonatomic, retain) IBOutlet UIView *selectionView;
@property (retain, nonatomic) IBOutlet UIView *rgbColourView;
@property (retain, nonatomic) IBOutlet UILabel *infoLabel;
@property (retain, nonatomic) IBOutlet UILabel *rgbLabel;
@property (retain, nonatomic) IBOutlet UILabel *hueLabel;
@property (retain, nonatomic) IBOutlet UIImageView *bottomGradient;
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
@property (retain, nonatomic) IBOutlet UIButton *smallOutput1;
@property (retain, nonatomic) IBOutlet UIButton *smallOutput2;
@property (retain, nonatomic) IBOutlet UIButton *smallOutput3;
@property (retain, nonatomic) IBOutlet UIButton *smallOutput4;
@property (retain, nonatomic) IBOutlet UIButton *smallOutput5;
@property (retain, nonatomic) IBOutlet UIButton *smallOutput6;
@property (retain, nonatomic) IBOutlet UIButton *smallOutput7;
@property (retain, nonatomic) IBOutlet UIButton *smallOutput8;
@property (retain, nonatomic) IBOutlet UIButton *outputButton1;
@property (retain, nonatomic) IBOutlet UIButton *outputButton2;
@property (retain, nonatomic) IBOutlet UIButton *outputButton3;
@property (retain, nonatomic) IBOutlet UIButton *outputButton4;
@property (retain, nonatomic) IBOutlet UIButton *outputButton5;
@property (retain, nonatomic) IBOutlet UIButton *outputButton6;
@property (retain, nonatomic) IBOutlet UIButton *outputButton7;
@property (retain, nonatomic) IBOutlet UIButton *outputButton8;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus1;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus2;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus3;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus4;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus5;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus6;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus7;
@property (retain, nonatomic) IBOutlet UILabel *targetStatus8;

@property (nonatomic, readonly) CGFloat heightScaleFactor;
@property (nonatomic, readonly) CGFloat widthScaleFactor;
@property (nonatomic, readonly) int pixelBufferWidth;
@property (nonatomic, readonly) int pixelBufferHeight;
@property (nonatomic, assign) CGFloat selectionX;
@property (nonatomic, assign) CGFloat selectionXimage;
@property (nonatomic, assign) CGFloat selectionY;
@property (nonatomic, retain) OutputsViewController *outputsViewController;
@property (nonatomic, readonly) BOOL locked;
@property (nonatomic, assign) BOOL isExposureLockSupported;
@property (nonatomic, assign) BOOL isFocusLockSupported;
@property (nonatomic, assign) int outputScreen;

@end
