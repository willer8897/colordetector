//
//  ViewController.m
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Target.h"

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
@synthesize settingsViewController;
@synthesize runButton;
@synthesize lockButton;
@synthesize photoButton;
@synthesize output1;
@synthesize output2;
@synthesize output3;
@synthesize output4;
@synthesize output5;
@synthesize output6;
@synthesize output7;
@synthesize output8;
@synthesize locked;
@synthesize currentColor;
@synthesize topLable;
@synthesize settingsButton;

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Interface buttons

- (IBAction)captureImage {
#ifdef DEBUG
  NSLog(@"Capture button pressed");
#endif
  captureImage = TRUE;
}

- (IBAction)showSettingsView {
#ifdef DEBUG
    NSLog(@"settings button pressed");
#endif
    [self presentModalViewController:settingsViewController animated:YES];
}

- (IBAction)startStop {
    if (running) {
        [self stopCameraCapture];
        [self.runButton setTitle:@"Off" forState:UIControlStateNormal];
        running = false;
    } else {
        [self startCameraCapture];
        [self.runButton setTitle:@"On" forState:UIControlStateNormal];
        running = true;
    }
}

- (IBAction)lockUnlock {
    if (locked) {
        [self.lockButton setTitle:@"U" forState:UIControlStateNormal];
        locked = false;
    } else {
        [self.lockButton setTitle:@"L" forState:UIControlStateNormal];
        locked = true;
    }
    [self.selectionView setNeedsDisplay];
}

- (IBAction)hideUI {
    if (uiHidden) {
        infoLabel.hidden = false;
        topLable.hidden = false;
        currentColor.hidden = false;
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
        [self.output2 setEnabled:true];
        output2.hidden = false;
        [self.output3 setEnabled:true];
        output3.hidden = false;
        [self.output4 setEnabled:true];
        output4.hidden = false;
        [self.output5 setEnabled:true];
        output5.hidden = false;
        [self.output6 setEnabled:true];
        output6.hidden = false;
        [self.output7 setEnabled:true];
        output7.hidden = false;
        [self.output8 setEnabled:true];
        output8.hidden = false;
        uiHidden = false;
    } else {
        infoLabel.hidden = true;
        topLable.hidden = true;
        currentColor.hidden = true;
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
        [self.output2 setEnabled:false];
        output2.hidden = true;
        [self.output3 setEnabled:false];
        output3.hidden = true;
        [self.output4 setEnabled:false];
        output4.hidden = true;
        [self.output5 setEnabled:false];
        output5.hidden = true;
        [self.output6 setEnabled:false];
        output6.hidden = true;
        [self.output7 setEnabled:false];
        output7.hidden = true;
        [self.output8 setEnabled:false];
        output8.hidden = true;
        uiHidden = true;
    }

}

#pragma mark - handle touch selections

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (running && !locked) {
        for (UITouch *touch in touches) {
            CGPoint loc = [touch locationInView:self.view];
#ifdef DEBUG
            NSLog(@"x -- %f y -- %f", loc.x, loc.y);
#endif
            // check to see that the x coordinate is not too far to the left
            // as this will cause a crash in the pixel averaging code
            // this should reposition the selection box close to the left edge in most situations
            if (loc.x < appDelegate.currentBoxWidth/appDelegate.widthScaleFactor/2) {
                loc.x = appDelegate.currentBoxWidth/appDelegate.widthScaleFactor/2-1;
#ifdef DEBUG
                NSLog(@"crash averted");
#endif
            }
            // shift the selection rectangle so it will draw centered on the user's touch
            selectionX = loc.x + (appDelegate.currentBoxWidth/2);
            selectionXimage = 320-selectionX;
            selectionY = loc.y - (appDelegate.currentBoxHeight/2);
#ifdef DEBUG
            NSLog(@"selectionX -- %f selectionY -- %f  selectionXimage -- %f", selectionX, selectionY, selectionXimage);
#endif
        }
        [self.selectionView setNeedsDisplay];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  appDelegate = [[UIApplication sharedApplication] delegate];
  settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
}

- (void)viewDidUnload
{
  [self setPreviewView:nil];
  [self setRgbColourView:nil];
  [self setInfoLabel:nil];
  [settingsViewController release];
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.selectionView setNeedsDisplay];
    // start grabbing frames from the camera
    running = true;
    [self.runButton setTitle:@"On" forState:UIControlStateNormal];
    [self.lockButton setTitle:@"U" forState:UIControlStateNormal];
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
void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v ) {
	float min, max, delta; 
	min = MIN( r, MIN(g, b )); 
	max = MAX( r, MAX(g, b )); 
	*v = max;
	delta = max - min; 
	if( max != 0 )
		*s = delta / max;
	else {
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

-(void) startCameraCapture {
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

#if DEBUG
    [self reportFocus:camera.focusMode];
    [self reportExposure:camera.exposureMode];
#endif

    // attempt to lock the focus and exposure
    NSError *error = nil;
#if DEBUG
    NSLog(@"Attempting to lock focus.");
#endif
    if ([camera isFocusModeSupported:AVCaptureFocusModeLocked]) {
        if ([camera lockForConfiguration:&error]) {
            camera.focusMode = AVCaptureFocusModeLocked;
            [camera unlockForConfiguration];
        } else {
            NSLog(@"Error trying to obtain configuration lock to set focus: %@",error);
        }
    }
#if DEBUG
    [self reportFocus:camera.focusMode];
#endif

#if DEBUG
    NSLog(@"Attempting to lock exposure.");
#endif
    if ([camera isExposureModeSupported:AVCaptureExposureModeLocked]) {
        if ([camera lockForConfiguration:&error]) {
            camera.exposureMode = AVCaptureExposureModeLocked;
            [camera unlockForConfiguration];
        } else {
            NSLog(@"Error trying to obtain configuration lock to set exposure: %@",error);
        }
    }
#if DEBUG
    [self reportExposure:camera.exposureMode];
#endif

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
	[session setSessionPreset:AVCaptureSessionPresetMedium]; // don't need high resolution capture
	
	// Add the input and output
	[session addInput:cameraInput];
	[session addOutput:videoOutput];
	
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
	// get the raw image bytes
	uint8_t *buf=(uint8_t *) CVPixelBufferGetBaseAddress(cvimgRef);
	size_t bprow=CVPixelBufferGetBytesPerRow(cvimgRef);
	float cr=0,cg=0,cb=0;
    // take a rectangular currentBoxWidth x currentBoxHeight section from the starting top left of the current rectangle
    pixelStartY = selectionY * appDelegate.heightScaleFactor;
    pixelStartX = selectionXimage * appDelegate.widthScaleFactor;
    int i, j;
    i = j = 0;
	for(int y=pixelStartX; i < appDelegate.currentBoxWidth; y++) {
		for(int x=pixelStartY; j < appDelegate.currentBoxHeight; x++) {
			cb+=buf[y*bprow+x*4];
			cg+=buf[y*bprow+x*4+1];
			cr+=buf[y*bprow+x*4+2];
            j++;
		}
        j = 0;
        i++;
	}
    // get the average RGB value in the range 0..1
	r=cr/(255.0f*appDelegate.currentBoxHeight*appDelegate.currentBoxWidth);
	g=cg/(255.0f*appDelegate.currentBoxHeight*appDelegate.currentBoxWidth);
	b=cb/(255.0f*appDelegate.currentBoxHeight*appDelegate.currentBoxWidth);
    // get the hue saturation and value (brightness)
    float ch,cs,cv;
    RGBtoHSV(r, g, b, &ch, &cs, &cv);
    h=ch; s=cs; v=cv;

    if (captureImage) {
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
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error != NULL) {
        NSLog(@"image not captured, error description: %@", [error localizedDescription]);
    }
    else {
        NSLog(@"image captured");
    }
}

- (void)drawSelectionRectToSavedImage {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    UIColor *color;
    if (appDelegate.viewController.locked) {
        color = [UIColor redColor];
    } else {
        color = [UIColor greenColor];
    }
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGRect rectangle = CGRectMake(selectionX*appDelegate.widthScaleFactor, selectionY*appDelegate.heightScaleFactor,
                                  -appDelegate.currentBoxWidth, appDelegate.currentBoxHeight);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
}

- (void)checkTargets {
    int red = r*255;
    int green = g*255;
    int blue = b*255;
    UIColor *color;
    for (int i = 0; i < [appDelegate.targets count]; ++i) {
        Target *t = [appDelegate.targets objectAtIndex:i];
        if (t.on) {
            // NoNc 1 equals NC
            if (t.NoNc) {
                color = [UIColor whiteColor];
            } else {
                color = [UIColor greenColor];
            }
            if ((red >= t.rl && red <= t.rh) &&
                (green >= t.gl && green <= t.gh) &&
                (blue >= t.bl && blue <= t.bh)) {
#ifdef DEBUG
                NSLog(@"Target %i hit.", i+1);
                static BOOL once[] = {NO, NO, NO, NO, NO, NO, NO, NO};
                if (t.light && !once[i]) {
                    NSLog(@"Output %i light triggered.", i+1);
                    once[i] = YES;
                }
#endif

                if (t.previousSample) {
                    t.beforeDelayCounter += .1;

                    if (t.beforeDelayCounter >= t.beforeDelay) {
#ifdef DEBUG
                        NSLog(@"beforeDelayCounter %f beforeDelay %f", t.beforeDelayCounter, t.beforeDelay);
                        NSLog(@"Indicator triggered.");
#endif
                        [self updateIndicator:i :color];
                        t.afterDelayCounter = t.afterDelay;
                    }
                }
                t.previousSample = YES;

            } else {
                if (t.afterDelayCounter > 0) {
                    t.afterDelayCounter -= .1;
                    [self updateIndicator:i :color];
                }
                t.previousSample = NO;
                t.beforeDelayCounter = 0;
            }

        }
    }
}

- (void)updateIndicator:(int)target :(UIColor *) color {

    switch (target+1) {
        case 1:
            [self.output1 setBackgroundColor:color];
            break;
        case 2:
            [self.output2 setBackgroundColor:color];
            break;
        case 3:
            [self.output3 setBackgroundColor:color];
            break;
        case 4:
            [self.output4 setBackgroundColor:color];
            break;
        case 5:
            [self.output5 setBackgroundColor:color];
            break;
        case 6:
            [self.output6 setBackgroundColor:color];
            break;
        case 7:
            [self.output7 setBackgroundColor:color];
            break;
        case 8:
            [self.output8 setBackgroundColor:color];
            break;

        default:
            break;
    }

}

// do this on a timer as the captureOutput runs on it's own thread and can't update the UI
-(void) updateUI {
    // the raw RGB colour
    rgbColourView.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    infoLabel.text = [NSString stringWithFormat:@"RGB=%.f,%.f,%.f Hue=%.f Sat=%.2f Val=%.2f", r*255, g*255, b*255, h, s, v];

    UIColor *color;
    for (int i = 0; i < [appDelegate.targets count]; ++i) {
        Target *t = [appDelegate.targets objectAtIndex:i];
        if (t.on) {
            // NoNc 1 equals NC
            if (t.NoNc) {
                color = [UIColor greenColor];
            } else {
                color = [UIColor whiteColor];
            }
        } else {
            color = [UIColor blackColor];
        }
        switch (i+1) {
            case 1:
                [self.output1 setBackgroundColor:color];
                break;
            case 2:
                [self.output2 setBackgroundColor:color];
                break;
            case 3:
                [self.output3 setBackgroundColor:color];
                break;
            case 4:
                [self.output4 setBackgroundColor:color];
                break;
            case 5:
                [self.output5 setBackgroundColor:color];
                break;
            case 6:
                [self.output6 setBackgroundColor:color];
                break;
            case 7:
                [self.output7 setBackgroundColor:color];
                break;
            case 8:
                [self.output8 setBackgroundColor:color];
                break;

            default:
                break;
        }
    }

  [self checkTargets];
}

-(void) stopCameraCapture {
	[session stopRunning];
	[session release];
	session=nil;
}

- (void)dealloc {
  [previewView release];
  [rgbColourView release];
  [infoLabel release];
  [super dealloc];
}

UIImage *imageFromSampleBuffer(CMSampleBufferRef sampleBuffer) {

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
  if (colorSpace == NULL) {
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
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

- (void)reportFocus:(int)focusMode {
    switch (focusMode) {
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
- (void)reportExposure:(int)exposureMode {
    switch (exposureMode) {
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

@end
