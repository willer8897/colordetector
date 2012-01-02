//
//  ViewController.h
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

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
  int pixelBufferWidth;
  int pixelBufferHeight;
  // the starting points for where the rectangle will be drawn
  CGFloat selectionX;
  CGFloat selectionXimage;
  CGFloat selectionY;
  int pixelStartX;
  int pixelStartY;
}

- (IBAction)captureImage;

@property (nonatomic, retain) IBOutlet UIView *previewView;
@property (nonatomic, retain) IBOutlet UIView *selectionView;
@property (retain, nonatomic) IBOutlet UIView *rgbColourView;
@property (retain, nonatomic) IBOutlet UIView *hueColourView;
@property (retain, nonatomic) IBOutlet UIView *closestColourView;
@property (retain, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, readonly) int pixelBufferWidth;
@property (nonatomic, readonly) int pixelBufferHeight;
@property (nonatomic, assign) CGFloat selectionX;
@property (nonatomic, assign) CGFloat selectionXimage;
@property (nonatomic, assign) CGFloat selectionY;

@end
