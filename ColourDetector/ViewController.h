//
//  ViewController.h
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SettingsViewController.h"

@class selectionView;
@class AppDelegate;

@interface ViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate> {
  AVCaptureSession *session;
  NSTimer *updateTimer;
  UIView *previewView;
  float r,g,b;
  float h,s,v;
  
  NSArray *targetColours;
  UIColor *closestColour;

  AppDelegate *appDelegate;
  BOOL captureImage;
  BOOL running;
  BOOL locked;
  BOOL uiHidden;
  int pixelBufferWidth;
  int pixelBufferHeight;
  // the starting points for where the rectangle will be drawn
  CGFloat selectionX;
  CGFloat selectionXimage;
  CGFloat selectionY;
  int pixelStartX;
  int pixelStartY;
  SettingsViewController *settingsViewController;
}

- (IBAction)captureImage;
- (IBAction)showSettingsView;
- (void)checkTargets;
- (IBAction)startStop;
- (IBAction)lockUnlock;
- (IBAction)hideUI;

@property (nonatomic, retain) IBOutlet UIView *previewView;
@property (nonatomic, retain) IBOutlet UIView *selectionView;
@property (retain, nonatomic) IBOutlet UIView *rgbColourView;
//@property (retain, nonatomic) IBOutlet UIView *hueColourView;
//@property (retain, nonatomic) IBOutlet UIView *closestColourView;
@property (retain, nonatomic) IBOutlet UILabel *infoLabel;
@property (retain, nonatomic) IBOutlet UILabel *currentColor;
@property (retain, nonatomic) IBOutlet UILabel *topLable;
@property (retain, nonatomic) IBOutlet UIButton *runButton;
@property (retain, nonatomic) IBOutlet UIButton *lockButton;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;
@property (retain, nonatomic) IBOutlet UIButton *settingsButton;
@property (retain, nonatomic) IBOutlet UIButton *output1;
@property (retain, nonatomic) IBOutlet UIButton *output2;
@property (retain, nonatomic) IBOutlet UIButton *output3;
@property (retain, nonatomic) IBOutlet UIButton *output4;
@property (retain, nonatomic) IBOutlet UIButton *output5;
@property (retain, nonatomic) IBOutlet UIButton *output6;
@property (retain, nonatomic) IBOutlet UIButton *output7;
@property (retain, nonatomic) IBOutlet UIButton *output8;
@property (nonatomic, readonly) int pixelBufferWidth;
@property (nonatomic, readonly) int pixelBufferHeight;
@property (nonatomic, assign) CGFloat selectionX;
@property (nonatomic, assign) CGFloat selectionXimage;
@property (nonatomic, assign) CGFloat selectionY;
@property (nonatomic, retain) SettingsViewController *settingsViewController;
@property (nonatomic, readonly) BOOL locked;

@end
