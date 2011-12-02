//
//  ViewController.h
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate> {
  AVCaptureSession *session;
  NSTimer *updateTimer;
  UIView *previewView;
  float r,g,b;
  float h,s,v;
  
  NSArray *targetColours;
  UIColor *closestColour;

  BOOL captureImage;
}

- (IBAction)captureImage;

@property (nonatomic, retain) IBOutlet UIView *previewView;
@property (retain, nonatomic) IBOutlet UIView *rgbColourView;
@property (retain, nonatomic) IBOutlet UIView *hueColourView;
@property (retain, nonatomic) IBOutlet UIView *closestColourView;
@property (retain, nonatomic) IBOutlet UILabel *infoLabel;

@end
