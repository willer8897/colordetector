//
//  ViewController.m
//  ColourDetectorCircleTest
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Target.h"
#import "saveFile.h"

@interface ViewController()

-(void) startCameraCapture;
-(void) stopCameraCapture;

@end

void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v );
UIImage *imageFromSampleBuffer(CMSampleBufferRef sampleBuffer);

@implementation ViewController
@synthesize previewView;
@synthesize selectionView;
@synthesize rgbColourView;
@synthesize infoLabel;
@synthesize pixelBufferWidth;
@synthesize pixelBufferHeight;
@synthesize selectionX;
@synthesize selectionXimage;
@synthesize selectionY;
@synthesize outputsViewController;
@synthesize runButton;
@synthesize lockButton;
@synthesize photoButton;
@synthesize outputsButton;
@synthesize output1;
@synthesize output2;
@synthesize output3;
@synthesize output4;
@synthesize output5;
@synthesize output6;
@synthesize output7;
@synthesize output8;
@synthesize smallOutput1;
@synthesize smallOutput2;
@synthesize smallOutput3;
@synthesize smallOutput4;
@synthesize smallOutput5;
@synthesize smallOutput6;
@synthesize smallOutput7;
@synthesize smallOutput8;
@synthesize outputButton1;
@synthesize outputButton2;
@synthesize outputButton3;
@synthesize outputButton4;
@synthesize outputButton5;
@synthesize outputButton6;
@synthesize outputButton7;
@synthesize outputButton8;
@synthesize targetStatus1;
@synthesize targetStatus2;
@synthesize targetStatus3;
@synthesize targetStatus4;
@synthesize targetStatus5;
@synthesize targetStatus6;
@synthesize targetStatus7;
@synthesize targetStatus8;
@synthesize locked;
@synthesize bottomGradient;
@synthesize settingsButton;
@synthesize isExposureLockSupported;
@synthesize isFocusLockSupported;
@synthesize rgbLabel;
@synthesize hueLabel;
@synthesize outputScreen;
@synthesize settingControlsBackgrounds;
@synthesize settingControlsLabels;
@synthesize selectionWidthTextField;
@synthesize selectionHeightTextField;
@synthesize startingXTextField;
@synthesize startingYTextField;
@synthesize exposureLock;
@synthesize focusLock;
@synthesize saveAsSettingsButton;
@synthesize selectionWidth;
@synthesize selectionHeight;
@synthesize startingX;
@synthesize startingY;
@synthesize heightScaleFactor;
@synthesize widthScaleFactor;
@synthesize drawSelector;
@synthesize horizontalMajorAxis;
@synthesize saveName;
@synthesize saveFiles;
@synthesize loadSettingsButton;
@synthesize filesTableViewController = _filesTVC;
@synthesize doneButton;
@synthesize saveButton;
@synthesize settingsControlsVisible;

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Interface buttons

- (IBAction)showOutputButtons
{
    if (settingsControlsVisible)
        return;
    if (!buttonsVisible)
    {
        outputButton1.hidden = false;
        outputButton2.hidden = false;
        outputButton3.hidden = false;
        outputButton4.hidden = false;
        outputButton5.hidden = false;
        outputButton6.hidden = false;
        outputButton7.hidden = false;
        outputButton8.hidden = false;
        for (int i = 0; i < [appDelegate.targets count]; ++i)
        {
            Target *t = [appDelegate.targets objectAtIndex:i];
            switch (i+1)
            {
                case 1:
                    if (t.on) {
                        [targetStatus1 setText:@"On"];
                    } else {
                        [targetStatus1 setText:@"Off"];
                    }
                    break;
                case 2:
                    if (t.on) {
                        [targetStatus2 setText:@"On"];
                    } else {
                        [targetStatus2 setText:@"Off"];
                    }
                    break;
                case 3:
                    if (t.on) {
                        [targetStatus3 setText:@"On"];
                    } else {
                        [targetStatus3 setText:@"Off"];
                    }
                    break;
                case 4:
                    if (t.on) {
                        [targetStatus4 setText:@"On"];
                    } else {
                        [targetStatus4 setText:@"Off"];
                    }
                    break;
                case 5:
                    if (t.on) {
                        [targetStatus5 setText:@"On"];
                    } else {
                        [targetStatus5 setText:@"Off"];
                    }
                    break;
                case 6:
                    if (t.on) {
                        [targetStatus6 setText:@"On"];
                    } else {
                        [targetStatus6 setText:@"Off"];
                    }
                    break;
                case 7:
                    if (t.on) {
                        [targetStatus7 setText:@"On"];
                    } else {
                        [targetStatus7 setText:@"Off"];
                    }
                    break;
                case 8:
                    if (t.on) {
                        [targetStatus8 setText:@"On"];
                    } else {
                        [targetStatus8 setText:@"Off"];
                    }
                    break;

                default:
                    break;
            }
        }
        targetStatus1.hidden = false;
        targetStatus2.hidden = false;
        targetStatus3.hidden = false;
        targetStatus4.hidden = false;
        targetStatus5.hidden = false;
        targetStatus6.hidden = false;
        targetStatus7.hidden = false;
        targetStatus8.hidden = false;
        buttonsVisible = true;
        [self stopCameraCapture];
    }
    else
    {
        outputButton1.hidden = true;
        outputButton2.hidden = true;
        outputButton3.hidden = true;
        outputButton4.hidden = true;
        outputButton5.hidden = true;
        outputButton6.hidden = true;
        outputButton7.hidden = true;
        outputButton8.hidden = true;
        targetStatus1.hidden = true;
        targetStatus2.hidden = true;
        targetStatus3.hidden = true;
        targetStatus4.hidden = true;
        targetStatus5.hidden = true;
        targetStatus6.hidden = true;
        targetStatus7.hidden = true;
        targetStatus8.hidden = true;
        buttonsVisible = false;
        [self startCameraCapture];
    }
}

- (IBAction)captureImage
{
  captureImage = TRUE;
}


- (IBAction)showSettingsControls
{

    if (buttonsVisible)
    {
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%i", appDelegate.currentBoxWidth];
    selectionWidthTextField.text = str;
    str = [NSString stringWithFormat:@"%i", appDelegate.currentBoxHeight];
    selectionHeightTextField.text = str;
    str = [NSString stringWithFormat:@"%i", appDelegate.startingSelectionX];
    startingXTextField.text = str;
    str = [NSString stringWithFormat:@"%i", appDelegate.startingSelectionY];
    startingYTextField.text = str;
    exposureLock.on = appDelegate.exposureLock;
    focusLock.on = appDelegate.focusLock;
    if(appDelegate.circleDraw)
        drawSelector.selectedSegmentIndex = 1;
    else
        drawSelector.selectedSegmentIndex = 0;
    if (self.isExposureLockSupported)
        exposureLock.enabled = YES;
    else
        exposureLock.enabled = NO;
    if (self.isFocusLockSupported)
        focusLock.enabled = YES;
    else
        focusLock.enabled = NO;
    
    [appDelegate saveAsSettings:appDelegate.fileName];
    if (!settingsControlsVisible)
    {
        for (UIImageView *imgView in settingControlsBackgrounds)
        {
            imgView.hidden = false;
        }
        for (UILabel *l in settingControlsLabels)
        {
            l.hidden = false;
        }
        selectionWidthTextField.hidden = false;
        selectionHeightTextField.hidden = false;
        startingXTextField.hidden = false;
        startingYTextField.hidden = false;
        exposureLock.hidden = false;
        focusLock.hidden = false;
        doneButton.hidden = false;
        saveButton.hidden = false;
        loadSettingsButton.hidden = false;
        saveAsSettingsButton.hidden = false;
        drawSelector.hidden = false;
        settingsControlsVisible = true;
        [self stopCameraCapture];
    }
    else
    {
        for (UIImageView *imgView in settingControlsBackgrounds)
        {
            imgView.hidden = true;
        }
        for (UILabel *l in settingControlsLabels)
        {
            l.hidden = true;
        }
        selectionWidthTextField.hidden = true;
        selectionHeightTextField.hidden = true;
        startingXTextField.hidden = true;
        startingYTextField.hidden = true;
        exposureLock.hidden = true;
        focusLock.hidden = true;
        doneButton.hidden = true;
        saveButton.hidden = true;
        loadSettingsButton.hidden = true;
        saveAsSettingsButton.hidden = true;
        drawSelector.hidden = true;
        settingsControlsVisible = false;
        [self startCameraCapture];
    }
    changeExposure = changeFocus = false;
}

- (IBAction)showOutputsView:(UIButton*)sender
{
    if ([sender isEqual:outputButton1])
        outputScreen = 1;
    if ([sender isEqual:outputButton2])
        outputScreen = 2;
    if ([sender isEqual:outputButton3])
        outputScreen = 3;
    if ([sender isEqual:outputButton4])
        outputScreen = 4;
    if ([sender isEqual:outputButton5])
        outputScreen = 5;
    if ([sender isEqual:outputButton6])
        outputScreen = 6;
    if ([sender isEqual:outputButton7])
        outputScreen = 7;
    if ([sender isEqual:outputButton8])
        outputScreen = 8;
    [appDelegate saveAsSettings:appDelegate.fileName];
    [self presentModalViewController:outputsViewController animated:YES];
}

- (IBAction)startStop
{
    drawSelector.hidden = true;
    if (running)
    {
        [self stopCameraCapture];
        [runButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        running = false;
    }
    else
    {
        [self startCameraCapture];
        [runButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        running = true;
    }
}

- (IBAction)lockUnlock
{
    if (locked)
    {
        [self.lockButton setBackgroundImage:[UIImage imageNamed:@"unlock_btn.png"] forState:UIControlStateNormal];
        locked = false;
    }
    else
    {
        [self.lockButton setBackgroundImage:[UIImage imageNamed:@"0001_lock_btn.png"] forState:UIControlStateNormal];
        locked = true;
    }
}

- (IBAction)hideUI
{
    if (buttonsVisible || settingsControlsVisible)
    {
        return;
    }
    if (uiHidden)
    {
        infoLabel.hidden = false;
        rgbLabel.hidden = false;
        hueLabel.hidden = false;
        bottomGradient.hidden = false;
        rgbColourView.hidden = false;
        [self.runButton setEnabled:true];
        runButton.hidden = false;
        [self.lockButton setEnabled:true];
        lockButton.hidden = false;
        [self.photoButton setEnabled:true];
        photoButton.hidden = false;
        [self.settingsButton setEnabled:true];
        settingsButton.hidden = false;
        [self.output1 setEnabled:true];
        output1.hidden = false;
        [self.smallOutput1 setEnabled:true];
        smallOutput1.hidden = false;
        [self.output2 setEnabled:true];
        output2.hidden = false;
        [self.smallOutput2 setEnabled:true];
        smallOutput2.hidden = false;
        [self.output3 setEnabled:true];
        output3.hidden = false;
        [self.smallOutput3 setEnabled:true];
        smallOutput3.hidden = false;
        [self.output4 setEnabled:true];
        output4.hidden = false;
        [self.smallOutput4 setEnabled:true];
        smallOutput4.hidden = false;
        [self.output5 setEnabled:true];
        output5.hidden = false;
        [self.smallOutput5 setEnabled:true];
        smallOutput5.hidden = false;
        [self.output6 setEnabled:true];
        output6.hidden = false;
        [self.smallOutput6 setEnabled:true];
        smallOutput6.hidden = false;
        [self.output7 setEnabled:true];
        output7.hidden = false;
        [self.smallOutput7 setEnabled:true];
        smallOutput7.hidden = false;
        [self.output8 setEnabled:true];
        output8.hidden = false;
        [self.smallOutput8 setEnabled:true];
        smallOutput8.hidden = false;
        outputsButton.hidden = false;
        uiHidden = false;
    }
    else
    {
        infoLabel.hidden = true;
        rgbLabel.hidden = true;
        hueLabel.hidden = true;
        bottomGradient.hidden = true;
        rgbColourView.hidden = true;
        [self.runButton setEnabled:false];
        runButton.hidden = true;
        [self.lockButton setEnabled:false];
        lockButton.hidden = true;
        [self.photoButton setEnabled:false];
        photoButton.hidden = true;
        [self.settingsButton setEnabled:false];
        settingsButton.hidden = true;
        [self.output1 setEnabled:false];
        output1.hidden = true;
        [self.smallOutput1 setEnabled:false];
        smallOutput1.hidden = true;
        [self.output2 setEnabled:false];
        output2.hidden = true;
        [self.smallOutput2 setEnabled:false];
        smallOutput2.hidden = true;
        [self.output3 setEnabled:false];
        output3.hidden = true;
        [self.smallOutput3 setEnabled:false];
        smallOutput3.hidden = true;
        [self.output4 setEnabled:false];
        output4.hidden = true;
        [self.smallOutput4 setEnabled:false];
        smallOutput4.hidden = true;
        [self.output5 setEnabled:false];
        output5.hidden = true;
        [self.smallOutput5 setEnabled:false];
        smallOutput5.hidden = true;
        [self.output6 setEnabled:false];
        output6.hidden = true;
        [self.smallOutput6 setEnabled:false];
        smallOutput6.hidden = true;
        [self.output7 setEnabled:false];
        output7.hidden = true;
        [self.smallOutput7 setEnabled:false];
        smallOutput7.hidden = true;
        [self.output8 setEnabled:false];
        output8.hidden = true;
        [self.smallOutput8 setEnabled:false];
        smallOutput8.hidden = true;
        outputsButton.hidden = true;
        uiHidden = true;
    }
}


#pragma mark - handle touch selections

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
        if (buttonsVisible || settingsControlsVisible)
            return;
        if(recognizer.state == UIGestureRecognizerStateChanged && recognizer.state != UIGestureRecognizerStateFailed)
        {
            if(recognizer.numberOfTouches == 2 && running && !locked)
            {
                CGPoint loc1 = [recognizer locationOfTouch:0 inView:self.view];
                CGPoint loc2 = [recognizer locationOfTouch:1 inView:self.view];
                CGPoint loc;
                loc.x = (loc2.x+loc1.x)/2;
                loc.y = (loc2.y+loc1.y)/2;
                if(loc2.y > loc1.y)
                    appDelegate.currentBoxHeight = loc2.y - loc1.y;
                else
                    appDelegate.currentBoxHeight = loc1.y - loc2.y;
                if(loc2.x > loc1.x)
                    appDelegate.currentBoxWidth = loc2.x - loc1.x;
                else
                    appDelegate.currentBoxWidth = loc1.x - loc2.x;
                
                //sets up the major and minor axises for ellipse drawing
                if(appDelegate.currentBoxHeight > appDelegate.currentBoxWidth)
                {
                    horizontalMajorAxis = false;
                    appDelegate.majorAxis = appDelegate.currentBoxHeight/2;
                    appDelegate.minorAxis = appDelegate.currentBoxWidth/2;
                }
                else if(appDelegate.currentBoxHeight <= appDelegate.currentBoxWidth)
                {
                    horizontalMajorAxis = true;
                    appDelegate.majorAxis = appDelegate.currentBoxWidth/2;
                    appDelegate.minorAxis = appDelegate.currentBoxHeight/2;
                }
                
                // check to see that the x coordinate is not too far to the left
                // as this will cause a crash in the pixel averaging code
                // this should reposition the selection box close to the left edge in most situations
                if (loc.x <= appDelegate.currentBoxWidth/widthScaleFactor/2)
                    loc.x = appDelegate.currentBoxWidth/widthScaleFactor/2-1;
                
                //check to see that the x coordinate is not too far to the right
                //this will make the pixel averaging code inaccurate
                //this should reposition the selection box close to the right edge
                if(loc.x >= appDelegate.screenRect.size.width - (appDelegate.currentBoxWidth/widthScaleFactor/2)-20)
                    loc.x = appDelegate.screenRect.size.width - (appDelegate.currentBoxWidth/widthScaleFactor/2)-21;
                
                //check to see that the y coordinate is not too far up
                //this will make the pixel averaging code inaccurate
                //this should reposition the selection close to the top
                if(loc.y <= appDelegate.currentBoxHeight/heightScaleFactor/2 + 10)
                    loc.y = appDelegate.currentBoxHeight/heightScaleFactor/2 + 11;
                
                //check to see that the y coordinate is not to far down
                //this will make the pixel averaging code inaccurate
                //this should reposition the selection close to the bottom
                if(loc.y >= appDelegate.screenRect.size.height - (appDelegate.currentBoxHeight/heightScaleFactor/2)-10)
                    loc.y = appDelegate.screenRect.size.height - (appDelegate.currentBoxHeight/heightScaleFactor/2)-11;
                
                // shift the selection rectangle so it will draw centered on the user's touch
                selectionX = loc.x + (appDelegate.currentBoxWidth/2);
                // the touch input x coordinate is reversed here since
                // the two views differ in the direction of their x axes
                selectionXimage = appDelegate.SCREEN_WIDTH_IN_POINTS - selectionX;
                selectionY = loc.y - (appDelegate.currentBoxHeight/2);
                appDelegate.startingSelectionX = selectionX;
                appDelegate.startingSelectionY = selectionY;
            }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (buttonsVisible || settingsControlsVisible)
        return;
    if (running && !locked)
    {
        for (UITouch *touch in touches)
        {
            CGPoint loc = [touch locationInView:self.view];
            #ifdef DEBUG
                //NSLog(@"x -- %f y -- %f", loc.x, loc.y);
            #endif
            // check to see that the x coordinate is not too far to the left
            // as this will cause a crash in the pixel averaging code
            // this should reposition the selection box close to the left edge in most situations
            if (loc.x < appDelegate.currentBoxWidth/widthScaleFactor/2)
            {
                loc.x = appDelegate.currentBoxWidth/widthScaleFactor/2-1;
                #ifdef DEBUG
                    NSLog(@"crash averted");
                #endif
            }
            
            //check to see that the x coordinate is not too far to the right
            //this will make the pixel averaging code inaccurate
            //this should reposition the selection box close to the right edge
            if(loc.x >= appDelegate.screenRect.size.width - (appDelegate.currentBoxWidth/widthScaleFactor/2) -20)
                loc.x = appDelegate.screenRect.size.width - (appDelegate.currentBoxWidth/widthScaleFactor/2) -21;
            
            //check to see that the y coordinate is not too far up
            //this will make the pixel averaging code inaccurate
            //this should reposition the selection close to the top
            if(loc.y <= appDelegate.currentBoxHeight/heightScaleFactor/2 + 10)
                loc.y = appDelegate.currentBoxHeight/heightScaleFactor/2 + 11;
            
            //check to see that the y coordinate is not to far down
            //this will make the pixel averaging code inaccurate
            //this should reposition the selection close to the bottom
            if(loc.y >= appDelegate.screenRect.size.height - (appDelegate.currentBoxHeight/heightScaleFactor/2)-10)
                loc.y = appDelegate.screenRect.size.height - (appDelegate.currentBoxHeight/heightScaleFactor/2)-11;
            
            // shift the selection rectangle so it will draw centered on the user's touch
            selectionX = loc.x + (appDelegate.currentBoxWidth/2);
            // the touch input x coordinate is reversed here since
            // the two views differ in the direction of their x axes
            selectionXimage = appDelegate.SCREEN_WIDTH_IN_POINTS - selectionX;
            selectionY = loc.y - (appDelegate.currentBoxHeight/2);
            appDelegate.startingSelectionX = selectionX;
            appDelegate.startingSelectionY = selectionY;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (buttonsVisible || settingsControlsVisible)
        return;
    if (running && !locked)
    {
        for (UITouch *touch in touches)
        {
            CGPoint loc = [touch locationInView:self.view];
            #ifdef DEBUG
                NSLog(@"x -- %f y -- %f", loc.x, loc.y);
            #endif
            // check to see that the x coordinate is not too far to the left
            // as this will cause a crash in the pixel averaging code
            // this should reposition the selection box close to the left edge in most situations
            if (loc.x < appDelegate.currentBoxWidth/widthScaleFactor/2)
            {
                loc.x = appDelegate.currentBoxWidth/widthScaleFactor/2-1;
                #ifdef DEBUG
                NSLog(@"crash averted");
                #endif
            }
            
            //check to see that the x coordinate is not too far to the right
            //this will make the pixel averaging code inaccurate
            //this should reposition the selection box close to the right edge
            if(loc.x >= appDelegate.screenRect.size.width - (appDelegate.currentBoxWidth/widthScaleFactor/2) -20)
                loc.x = appDelegate.screenRect.size.width - (appDelegate.currentBoxWidth/widthScaleFactor/2) -21;
            
            //check to see that the y coordinate is not too far up
            //this will make the pixel averaging code inaccurate
            //this should reposition the selection close to the top
            if(loc.y <= appDelegate.currentBoxHeight/heightScaleFactor/2 + 10)
                loc.y = appDelegate.currentBoxHeight/heightScaleFactor/2 + 11;
            
            //check to see that the y coordinate is not to far down
            //this will make the pixel averaging code inaccurate
            //this should reposition the selection close to the bottom
            if(loc.y >= appDelegate.screenRect.size.height - (appDelegate.currentBoxHeight/heightScaleFactor/2)-10)
                loc.y = appDelegate.screenRect.size.height - (appDelegate.currentBoxHeight/heightScaleFactor/2)-11;
            
            // shift the selection rectangle so it will draw centered on the user's touch
            selectionX = loc.x + (appDelegate.currentBoxWidth/2);
            // the touch input x coordinate is reversed here since
            // the two views differ in the direction of their x axes
            selectionXimage = appDelegate.SCREEN_WIDTH_IN_POINTS - selectionX;
            selectionY = loc.y - (appDelegate.currentBoxHeight/2);
            appDelegate.startingSelectionX = selectionX;
            appDelegate.startingSelectionY = selectionY;
            #ifdef DEBUG
                NSLog(@"selectionX -- %f selectionY -- %f  selectionXimage -- %f", selectionX, selectionY, selectionXimage);
            #endif
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    outputsViewController = [[OutputsViewController alloc] initWithNibName:@"OutputsViewController" bundle:[NSBundle mainBundle]];
}

- (void)viewDidUnload
{
  [self setPreviewView:nil];
  [self setRgbColourView:nil];
  [self setInfoLabel:nil];
  [outputsViewController release];
  [self setSelectionWidthTextField:nil];
  [self setSelectionHeightTextField:nil];
  [self setStartingXTextField:nil];
  [self setStartingYTextField:nil];
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    outputButton1.hidden = true;
    outputButton2.hidden = true;
    outputButton3.hidden = true;
    outputButton4.hidden = true;
    outputButton5.hidden = true;
    outputButton6.hidden = true;
    outputButton7.hidden = true;
    outputButton8.hidden = true;
    targetStatus1.hidden = true;
    targetStatus2.hidden = true;
    targetStatus3.hidden = true;
    targetStatus4.hidden = true;
    targetStatus5.hidden = true;
    targetStatus6.hidden = true;
    targetStatus7.hidden = true;
    targetStatus8.hidden = true;
    buttonsVisible = false;
    for (UIImageView *imgView in settingControlsBackgrounds)
    {
        imgView.hidden = true;
    }
    for (UILabel *l in settingControlsLabels)
    {
        l.hidden = true;
    }
    selectionWidthTextField.hidden = true;
    selectionHeightTextField.hidden = true;
    startingXTextField.hidden = true;
    startingYTextField.hidden = true;
    exposureLock.hidden = true;
    focusLock.hidden = true;
    doneButton.hidden = true;
    saveButton.hidden = true;
    loadSettingsButton.hidden = true;
    saveAsSettingsButton.hidden = true;
    drawSelector.hidden = true;
    settingsControlsVisible = false;
    // start grabbing frames from the camera
    running = true;
    [self startCameraCapture];
    // start updating the UI
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopCameraCapture];
    running = false;
    [updateTimer invalidate]; updateTimer = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark camera processing

// r,g,b values are from 0 to 1 // h = [0,360], s = [0,1], v = [0,1] 
//	if s == 0, then h = -1 (undefined) 
void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v )
{
	float min, max, delta; 
	min = MIN( r, MIN(g, b )); 
	max = MAX( r, MAX(g, b )); 
	*v = max;
	delta = max - min; 
	if( max != 0 )
		*s = delta / max;
	else
    {
		// r = g = b = 0 
		*s = 0; 
		*h = -1; 
		return;
	}
	if( r == max )
		*h = ( g - b ) / delta; 
	else if( g == max )
		*h=2+(b-r)/delta;
	else 
		*h=4+(r-g)/delta; 
	*h *= 60;
	if( *h < 0 ) 
		*h += 360;
}

-(void) startCameraCapture
{
	// start capturing frames
	// Create the AVCapture Session
	session = [[AVCaptureSession alloc] init];
	// create a preview layer to show the output from the camera
	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	// Specify that the video should be stretched to fill the layer’s bounds.
	previewLayer.videoGravity = AVLayerVideoGravityResize;
	previewLayer.frame = previewView.frame;
	[previewView.layer addSublayer:previewLayer];
  	
	// Get the default camera device
	AVCaptureDevice* camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // get the current settings
    [appDelegate loadFileSettings:appDelegate.fileName];
    [appDelegate loadTargets];
    if ([camera isFocusModeSupported:AVCaptureFocusModeLocked])
    {
        self.isFocusLockSupported = YES;
    }
    if ([camera isExposureModeSupported:AVCaptureExposureModeLocked])
    {
        self.isExposureLockSupported = YES;
    }

#if DEBUG_SETTINGS
    [self reportFocus:camera.focusMode];
    [self reportExposure:camera.exposureMode];
#endif

    // attempt to lock the focus and exposure
    NSError *error = nil;
    if (self.isFocusLockSupported)
    {
        if (appDelegate.focusLock)
        {
#if DEBUG_SETTINGS
            NSLog(@"Attempting to lock focus.");
#endif
            if ([camera isFocusModeSupported:AVCaptureFocusModeLocked])
            {
                if ([camera lockForConfiguration:&error])
                {
                    camera.focusMode = AVCaptureFocusModeLocked;
                    [camera unlockForConfiguration];
                }
                else
                {
                    NSLog(@"Error trying to obtain configuration lock to set focus: %@",error);
                }
            }

        }
        else
        {
#if DEBUG_SETTINGS
            NSLog(@"Unlocking focus.");
#endif
            if ([camera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
            {
                if ([camera lockForConfiguration:&error])
                {
                    camera.focusMode = AVCaptureFocusModeContinuousAutoFocus;
                    [camera unlockForConfiguration];
                }
                else
                {
                    NSLog(@"Error trying to obtain configuration lock to set focus: %@",error);
                }
            }
        }
#if DEBUG_SETTINGS
        [self reportFocus:camera.focusMode];
#endif
    }
    else
    {
        NSLog(@"Focus locking not supported on this device.");
    }

    if (self.isExposureLockSupported)
    {
        if (appDelegate.exposureLock)
        {
#if DEBUG_SETTINGS
            NSLog(@"Attempting to lock exposure.");
#endif
            if ([camera isExposureModeSupported:AVCaptureExposureModeLocked])
            {
                if ([camera lockForConfiguration:&error])
                {
                    camera.exposureMode = AVCaptureExposureModeLocked;
                    [camera unlockForConfiguration];
                }
                else
                {
                    NSLog(@"Error trying to obtain configuration lock to set exposure: %@",error);
                }
            }

        }
        else
        {
#if DEBUG_SETTINGS
            NSLog(@"Unlocking exposure.");
#endif
            if ([camera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
            {
                if ([camera lockForConfiguration:&error])
                {
                    camera.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
                    [camera unlockForConfiguration];
                }
                else
                {
                    NSLog(@"Error trying to obtain configuration lock to set exposure: %@",error);
                }
            }
        }
#if DEBUG_SETTINGS
        [self reportExposure:camera.exposureMode];
#endif
    }
    else
    {
        NSLog(@"Exposure locking not supported on this device.");
    }


	// Create a AVCaptureInput with the camera device
	error=nil;
	AVCaptureInput* cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:&error];
	if (cameraInput == nil) {
		NSLog(@"Error to create camera capture:%@",error);
	}
	
	// Set the output
	AVCaptureVideoDataOutput* videoOutput = [[AVCaptureVideoDataOutput alloc] init];
	
	// create a queue to run the capture on
	dispatch_queue_t captureQueue=dispatch_queue_create("catpureQueue", NULL);
	
	// setup our delegate
	[videoOutput setSampleBufferDelegate:self queue:captureQueue];
  
	// configure the pixel format
	videoOutput.videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA], (id)kCVPixelBufferPixelFormatTypeKey,nil];
	videoOutput.minFrameDuration=CMTimeMake(1, 10);
	// and the size of the frames we want
    if ([session canSetSessionPreset:@"AVCaptureSessionPresetMedium"])
        [session setSessionPreset:AVCaptureSessionPresetMedium];
    else
        NSLog(@"Session preset not supported.");
	
	// Add the input and output
    if ([session canAddInput:cameraInput])
        [session addInput:cameraInput];
    else
        NSLog(@"Error: cannot add camera input.");
	
    if ([session canAddOutput:videoOutput])
        [session addOutput:videoOutput];
    else
        NSLog(@"Error: cannot add video output.");

	// Start the session
	[session startRunning];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // this is the image buffer
	CVImageBufferRef cvimgRef = CMSampleBufferGetImageBuffer(sampleBuffer);
	// Lock the image buffer
	CVPixelBufferLockBaseAddress(cvimgRef,0);
	// access the data
	int width=CVPixelBufferGetWidth(cvimgRef);
	int height=CVPixelBufferGetHeight(cvimgRef);
    // the CVPixelBufferGet* methods give the height and width in landscape
    // it's swapped here since the selectionView's coordinates are in portrait
    pixelBufferHeight = width;
    pixelBufferWidth = height;
    heightScaleFactor = pixelBufferHeight / appDelegate.SCREEN_HEIGHT_IN_POINTS;
    widthScaleFactor = pixelBufferWidth / appDelegate.SCREEN_WIDTH_IN_POINTS;
	// get the raw image bytes
	uint8_t *buf=(uint8_t *) CVPixelBufferGetBaseAddress(cvimgRef);
	size_t bprow=CVPixelBufferGetBytesPerRow(cvimgRef);
	float cr=0,cg=0,cb=0;
    // take a rectangular currentBoxWidth x currentBoxHeight section from the starting top left of the current rectangle
    pixelStartY = selectionY * heightScaleFactor;
    pixelStartX = selectionXimage * widthScaleFactor;
    int i, j;
    i = j = 0;
    //set the center of the ellipse
    //scale so it is compatable with the pixel buffer
    double centerX = (selectionXimage + appDelegate.currentBoxWidth/2.0)*widthScaleFactor;
    double centerY = (selectionY + appDelegate.currentBoxHeight/2.0)*heightScaleFactor;
    double aSquared, bSquared;
    if(horizontalMajorAxis)
    {
        aSquared = (appDelegate.currentBoxWidth/2.0)*(appDelegate.currentBoxWidth/2.0);
        bSquared = (appDelegate.currentBoxHeight/2.0)*(appDelegate.currentBoxHeight/2.0);
    }
    if(!horizontalMajorAxis)
    {
        bSquared = (appDelegate.currentBoxWidth/2.0)*(appDelegate.currentBoxWidth/2.0);
        aSquared = (appDelegate.currentBoxHeight/2.0)*(appDelegate.currentBoxHeight/2.0);
    }
    int pixelsProcessed = 0;
    if(!appDelegate.circleDraw)
    {
        for(int y=pixelStartX; i < appDelegate.currentBoxWidth; y++)
        {
            for(int x=pixelStartY; j < appDelegate.currentBoxHeight; x++)
            {
                ///handle random pinch errors
                if((((y) < pixelBufferWidth) && ((x) < pixelBufferHeight)) && CMSampleBufferIsValid(sampleBuffer))
                {
                    cb+=buf[y*bprow+x*4];
                    cg+=buf[y*bprow+x*4+1];
                    cr+=buf[y*bprow+x*4+2];
                    pixelsProcessed++;
                }
                j++;
            }
            j = 0;
            i++;
        }
    }

    //get the color sums if the selection is an ellipse
    //checks if the pixels are within the equation of the ellipse
    //.03 is added onto the ellipse comparison to account for some divided pixels
    //the number of pixels processed accounts for 98%-99% of the area of the ellipse
    if(appDelegate.circleDraw)
    {
        pixelsProcessed = 0;
        for(int y=pixelStartX; i < appDelegate.currentBoxWidth; y++)
        {
            for(int x=pixelStartY; j < appDelegate.currentBoxHeight; x++)
            {
                double xTop = (y-centerX)*(y-centerX);
                double yTop = (x-centerY)*(x-centerY);
                double xQuo, yQuo;
                if(horizontalMajorAxis)
                    
                {
                    xQuo = xTop/aSquared;
                    yQuo = yTop/bSquared;
                }
                else
                {
                    xQuo = xTop/bSquared;
                    yQuo = yTop/aSquared;
                }
                ///handle random pinch errors and check ellipse equation
                if((((y) < pixelBufferWidth) && ((x) < pixelBufferHeight) && ((xQuo+yQuo) <=1.03) && CMSampleBufferIsValid(sampleBuffer)))
                {
                    cb+=buf[y*bprow+x*4];
                    cg+=buf[y*bprow+x*4+1];
                    cr+=buf[y*bprow+x*4+2];
                    pixelsProcessed++;
                }
                j++;
            }
            j = 0;
            i++;
        }
    }

    //replaced 255.0f*currentBoxWidth*currentBoxHeight with below code
    //this new code accounts for a better average when working with circles and error reduced rectangles
    // get the average RGB value in the range 0..1
    r=cr/(255.0f*pixelsProcessed);
    g=cg/(255.0f*pixelsProcessed);
    b=cb/(255.0f*pixelsProcessed);
    // get the hue saturation and value (brightness)
    float ch,cs,cv;
    RGBtoHSV(r, g, b, &ch, &cs, &cv);
    h=ch; s=cs; v=cv;
    if (captureImage)
    {
        captureImage = false;
        // combine current image capture with current selection rectangle
        UIImage *image = imageFromSampleBuffer(sampleBuffer);
        CGSize image_size = CGSizeMake(pixelBufferWidth, pixelBufferHeight);
        UIGraphicsBeginImageContextWithOptions(image_size, NO, 1.0);
        [image drawAtPoint:CGPointMake(0, 0)];
        [self drawSelectionRectToSavedImage];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // Request to save the image to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        sleep(1);
    }
    CVPixelBufferUnlockBaseAddress(cvimgRef, 0);
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL)
        NSLog(@"image not captured, error description: %@", [error localizedDescription]);
    else
        NSLog(@"image captured");
}

- (void)drawSelectionRectToSavedImage
{
    if(!appDelegate.circleDraw)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 2.0);
        UIColor *color;
        if (appDelegate.viewController.locked)
            color = [UIColor redColor];
        else
            color = [UIColor greenColor];
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGRect rectangle = CGRectMake(selectionX*widthScaleFactor, selectionY*heightScaleFactor,
                                  -appDelegate.currentBoxWidth, appDelegate.currentBoxHeight);
        CGContextAddRect(context, rectangle);
        CGContextStrokePath(context);
    }
    if(appDelegate.circleDraw)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 2.0);
        UIColor *color;
        if(appDelegate.viewController.locked)
            color = [UIColor redColor];
        else
            color = [UIColor greenColor];
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGRect rectangle = CGRectMake(selectionX*widthScaleFactor, selectionY*heightScaleFactor,
                                      -appDelegate.currentBoxWidth, appDelegate.currentBoxHeight);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
    }
}

- (void)checkTargets
{
    int red = r*255;
    int green = g*255;
    int blue = b*255;
    UIImage *largeIndictator, *smallIndicator;
    for (int i = 0; i < [appDelegate.targets count]; ++i)
    {
        Target *t = [appDelegate.targets objectAtIndex:i];
        if (t.on)
        {
            // NoNc 1 equals NC
            if (t.NoNc)
            {
                largeIndictator = [UIImage imageNamed:@"green_indicator(lrg).png"];
                smallIndicator = [UIImage imageNamed:@"green_indicator(small).png"];
            }
            else
            {
                largeIndictator = [UIImage imageNamed:@"ylw_indicator(lrg).png"];
                smallIndicator = [UIImage imageNamed:@"yllw_indicator(small).png"];
            }
            if ((red >= t.rl && red <= t.rh) &&
                (green >= t.gl && green <= t.gh) &&
                (blue >= t.bl && blue <= t.bh))
            {
#ifdef DEBUG
                NSLog(@"Target %i hit.", i+1);
                static BOOL once[] = {NO, NO, NO, NO, NO, NO, NO, NO};
                if (t.light && !once[i])
                {
                    NSLog(@"Output %i light triggered.", i+1);
                    once[i] = YES;
                }
#endif

                if (t.previousSample)
                {
                    t.beforeDelayCounter += .1;

                    if (t.beforeDelayCounter >= t.beforeDelay)
                    {
#ifdef DEBUG_TIMING
                        NSLog(@"beforeDelayCounter %f beforeDelay %f", t.beforeDelayCounter, t.beforeDelay);
                        NSLog(@"Indicator triggered.");
#endif
                        [self updateIndicator:i :largeIndictator :smallIndicator];
                        t.afterDelayCounter = t.afterDelay;
                    }
                }
                t.previousSample = YES;

            }
            else
            {
                if (t.afterDelayCounter > 0)
                {
                    t.afterDelayCounter -= .1;
                    [self updateIndicator:i :largeIndictator :smallIndicator];
                }
                t.previousSample = NO;
                t.beforeDelayCounter = 0;
            }
        }
    }
}

- (void)updateIndicator:(int)target :(UIImage *) largeIndictator :(UIImage *)smallIndicator
{

    switch (target+1)
    {
        case 1:
            [self.output1 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput1 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;
        case 2:
            [self.output2 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput2 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;
        case 3:
            [self.output3 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput3 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;
        case 4:
            [self.output4 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput4 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;
        case 5:
            [self.output5 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput5 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;
        case 6:
            [self.output6 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput6 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;
        case 7:
            [self.output7 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput7 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;
        case 8:
            [self.output8 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
            [self.smallOutput8 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
            break;

        default:
            break;
    }

}

// do this on a timer as the captureOutput runs on it's own thread and can't update the UI
-(void) updateUI
{
    // the raw RGB colour
    rgbColourView.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    rgbLabel.text = [NSString stringWithFormat:@"RGB = %.f,%.f,%.f", r*255, g*255, b*255];
    hueLabel.text = [NSString stringWithFormat:@"Hue = %.f Sat = %.2f Val = %.2f", h, s, v];

    UIImage *largeIndictator, *smallIndicator;
    for (int i = 0; i < [appDelegate.targets count]; ++i)
    {
        Target *t = [appDelegate.targets objectAtIndex:i];
        if (t.on)
        {
            // NoNc 1 equals NC
            if (t.NoNc)
            {
                largeIndictator = [UIImage imageNamed:@"ylw_indicator(lrg).png"];
                smallIndicator = [UIImage imageNamed:@"yllw_indicator(small).png"];
            } else
            {
                largeIndictator = [UIImage imageNamed:@"green_indicator(lrg).png"];
                smallIndicator = [UIImage imageNamed:@"green_indicator(small).png"];
            }
        }
        else
        {
            largeIndictator = [UIImage imageNamed:@"red_indicator(lrg).png"];
            smallIndicator = [UIImage imageNamed:@"red_indicator(small).png"];
        }
        switch (i+1)
        {
            case 1:
                [self.output1 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput1 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;
            case 2:
                [self.output2 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput2 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;
            case 3:
                [self.output3 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput3 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;
            case 4:
                [self.output4 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput4 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;
            case 5:
                [self.output5 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput5 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;
            case 6:
                [self.output6 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput6 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;
            case 7:
                [self.output7 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput7 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;
            case 8:
                [self.output8 setBackgroundImage:largeIndictator forState:UIControlStateNormal];
                [self.smallOutput8 setBackgroundImage:smallIndicator forState:UIControlStateNormal];
                break;

            default:
                break;
        }
    }

  [self checkTargets];
  [self.selectionView setNeedsDisplay];
}

-(void) stopCameraCapture
{
	[session stopRunning];
	[session release];
	session=nil;
}

- (void)dealloc
{
  [previewView release];
  [rgbColourView release];
  [infoLabel release];
  [super dealloc];
}

UIImage *imageFromSampleBuffer(CMSampleBufferRef sampleBuffer)
{

  CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
  // Lock the base address of the pixel buffer.
  CVPixelBufferLockBaseAddress(imageBuffer,0);

  // Get the number of bytes per row for the pixel buffer.
  size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
  // Get the pixel buffer width and height.
  size_t width = CVPixelBufferGetWidth(imageBuffer);
  size_t height = CVPixelBufferGetHeight(imageBuffer);

  // Create a device-dependent RGB color space.
  static CGColorSpaceRef colorSpace = NULL;
  if (colorSpace == NULL)
  {
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
      // Handle the error appropriately.
      return nil;
    }
  }

  // Get the base address of the pixel buffer.
  void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
  // Get the data size for contiguous planes of the pixel buffer.
  size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);

  // Create a Quartz direct-access data provider that uses data we supply.
  CGDataProviderRef dataProvider =
  CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, NULL);
  // Create a bitmap image from data supplied by the data provider.
  CGImageRef cgImage =
  CGImageCreate(width, height, 8, 32, bytesPerRow,
                colorSpace, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little,
                dataProvider, NULL, true, kCGRenderingIntentDefault);
  CGDataProviderRelease(dataProvider);

  // Create and return an image object to represent the Quartz image.
  UIImage *image = [UIImage imageWithCGImage:cgImage scale:1.0 orientation:UIImageOrientationRight];
  CGImageRelease(cgImage);

  CVPixelBufferUnlockBaseAddress(imageBuffer, 0);

  return image;
}

- (void)reportFocus:(int)focusMode
{
    switch (focusMode)
    {
        case 0:
            NSLog(@"Focus mode is AVCaptureFocusModeLocked");
            NSLog(@"The focus is locked.");
            break;
        case 1:
            NSLog(@"Focus mode is AVCaptureFocusModeAutoFocus");
            NSLog(@"The capture device performs an autofocus operation now.");
            break;
        case 2:
            NSLog(@"Focus mode is AVCaptureFocusModeContinuousAutoFocus");
            NSLog(@"The capture device continuously monitors focus and auto focuses when necessary.");
            break;

        default:
            break;
    }
}

- (void)reportExposure:(int)exposureMode
{
    switch (exposureMode)
    {
        case 0:
            NSLog(@"Exposure mode is AVCaptureExposureModeLocked");
            NSLog(@"The exposure setting is locked.");
            break;
        case 1:
            NSLog(@"Exposure mode is AVCaptureExposureModeAutoExpose");
            NSLog(@"The device performs an auto-expose operation now.");
            break;
        case 2:
            NSLog(@"Exposure mode is AVCaptureExposureModeContinuousAutoExposure");
            NSLog(@"The device continuously monitors exposure levels and auto exposes when necessary.");
            break;

        default:
            break;
    }
}

#pragma mark - Settings


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //cancel button is always at index 1
    if(buttonIndex == 1)
        return;
    if(alertView.title == @"No Files Saved")
        return;
    //handles save button press
    if(buttonIndex == 0)
    {
        saveName = [[alertView textFieldAtIndex:0] text];
        appDelegate.fileName = saveName;
        if (changeExposure)
        {
            appDelegate.exposureLock = !appDelegate.exposureLock;
            changeExposure = FALSE;
        }
        if (changeFocus)
        {
            appDelegate.focusLock = !appDelegate.focusLock;
            changeFocus = FALSE;
        }
        
        if(drawSelector.selectedSegmentIndex == 0)
            appDelegate.circleDraw = FALSE;
        if(drawSelector.selectedSegmentIndex == 1)
            appDelegate.circleDraw = TRUE;
        
        [appDelegate saveAsSettings:saveName];
        [appDelegate setStartingCoordinates];
        [appDelegate saveTargets];
        settingsControlsVisible = true;
        [self showSettingsControls];
        [self.selectionView setNeedsDisplay];
    }
}

- (IBAction)savePressed:(id)sender
{
     if (changeExposure)
     {
     appDelegate.exposureLock = !appDelegate.exposureLock;
     changeExposure = FALSE;
     }
     if (changeFocus)
     {
     appDelegate.focusLock = !appDelegate.focusLock;
     changeFocus = FALSE;
     }
     
     if(drawSelector.selectedSegmentIndex == 0)
     appDelegate.circleDraw = FALSE;
     if(drawSelector.selectedSegmentIndex == 1)
     appDelegate.circleDraw = TRUE;
     

     appDelegate.currentBoxWidth = [selectionWidthTextField.text intValue];
     appDelegate.currentBoxHeight = [selectionHeightTextField.text intValue];
     appDelegate.startingSelectionX = [startingXTextField.text intValue];
     appDelegate.startingSelectionY = [startingYTextField.text intValue];
     
     [appDelegate saveAsSettings:appDelegate.fileName];
     [appDelegate setStartingCoordinates];
     settingsControlsVisible = true;
     [self showSettingsControls];
     [self.selectionView setNeedsDisplay];
}

- (IBAction)donePressed:(id)sender
{
    //resets all fields to current settings.
    selectionWidthTextField.text = [NSString stringWithFormat:@"%i",appDelegate.currentBoxWidth];
    selectionHeightTextField.text = [NSString stringWithFormat:@"%i", appDelegate.currentBoxHeight];
    startingXTextField.text = [NSString stringWithFormat:@"%i", appDelegate.startingSelectionX];
    startingYTextField.text = [NSString stringWithFormat:@"%i", appDelegate.startingSelectionY];
    //reset exposure and focus lock also
    if(appDelegate.circleDraw == FALSE)
        [drawSelector setSelectedSegmentIndex:0];
    if(appDelegate.circleDraw)
        [drawSelector setSelectedSegmentIndex:1];
    if(appDelegate.focusLock)
        [focusLock setOn:YES animated:TRUE];
    else
        [focusLock setOn:NO animated:TRUE];
    if(appDelegate.exposureLock)
        [exposureLock setOn:YES animated:TRUE];
    else
        [exposureLock setOn:NO animated:TRUE];
    
    settingsControlsVisible = true;
    [self showSettingsControls];
}


- (IBAction)saveAsSettings:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save As" message:@"Enter the name for the save file. This will save selection and target settings" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:@"Cancel", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)loadSettings:(UIButton *)sender
{
    NSArray *fileNames = [appDelegate getFileNames];
    if([fileNames count] > 0)
    {
        _filesTVC = [[FilesTableViewController alloc] init];
        [appDelegate.window addSubview:_filesTVC.view];
        _filesTVC.view.hidden = false;
        settingsControlsVisible = true;
        [self showSettingsControls];
    }
    else
    {
        UIAlertView *noSavesAlert = [[UIAlertView alloc] initWithTitle:@"No Files Saved" message:@"You have no saved files!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        noSavesAlert.AlertViewStyle = UIAlertViewStyleDefault;
        [noSavesAlert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    self.selectionWidth = self.selectionWidthTextField.text;
    self.selectionHeight = self.selectionHeightTextField.text;
    self.startingX = self.startingXTextField.text;
    self.startingY = self.startingYTextField.text;
#ifdef DEBUG
    NSLog(@"selectionWidth -- %@", self.selectionWidth);
    NSLog(@"selectionHeight -- %@", self.selectionHeight);
    NSLog(@"startingX -- %@", self.startingX);
    NSLog(@"startingY -- %@", self.startingY);
#endif
    return YES;
}

- (IBAction)exposureLockChanged:(UISwitch*)sender
{
    changeExposure = TRUE;
}

- (IBAction)focusLockChanged:(UISwitch*)sender
{
    changeFocus = TRUE;
}

@end
