//
//  ViewController.m
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

-(void) startCameraCapture;
-(void) stopCameraCapture;

@end

void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v );

@implementation ViewController
@synthesize previewView;
@synthesize rgbColourView;
@synthesize hueColourView;
@synthesize closestColourView;
@synthesize infoLabel;

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  // crate some target colours to match against
  targetColours = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor yellowColor], nil];
}

- (void)viewDidUnload
{
  [targetColours release]; targetColours=nil;
  [self setPreviewView:nil];
  [self setRgbColourView:nil];
  [self setHueColourView:nil];
  [self setClosestColourView:nil];
  [self setInfoLabel:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  // start grabbing frames from the camera
  [self startCameraCapture];
  // start updating the UI
  updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
  [self stopCameraCapture];
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
	previewLayer.frame = previewView.frame;
	[previewView.layer addSublayer:previewLayer];
  	
	// Get the default camera device
	AVCaptureDevice* camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

	// Create a AVCaptureInput with the camera device
	NSError *error=nil;
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
	videoOutput.videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA], (id)kCVPixelBufferPixelFormatTypeKey,
                               nil];
	videoOutput.minFrameDuration=CMTimeMake(1, 10);
	// and the size of the frames we want
	[session setSessionPreset:AVCaptureSessionPresetLow]; // don't need high resolution capture
	
	// Add the input and output
	[session addInput:cameraInput];
	[session addOutput:videoOutput];
	
	// Start the session
	[session startRunning];		
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
	static int count=0;
	count++;
	// only run if we're not already processing an image
	// this is the image buffer
	CVImageBufferRef cvimgRef = CMSampleBufferGetImageBuffer(sampleBuffer);
	// Lock the image buffer
	CVPixelBufferLockBaseAddress(cvimgRef,0);
	// access the data
	int width=CVPixelBufferGetWidth(cvimgRef);
	int height=CVPixelBufferGetHeight(cvimgRef);
	// get the raw image bytes
	uint8_t *buf=(uint8_t *) CVPixelBufferGetBaseAddress(cvimgRef);
	size_t bprow=CVPixelBufferGetBytesPerRow(cvimgRef);
	float cr=0,cg=0,cb=0;
  // take a square 100x100 section in the middle of the image
	for(int y=height/2-50; y<height/2+50; y++) {
		for(int x=width/2-50; x<width/2+50; x++) {
			cb+=buf[y*bprow+x*4];
			cg+=buf[y*bprow+x*4+1];
			cr+=buf[y*bprow+x*4+2];
		}
	}
  // get the average RGB value in the range 0..1
	r=cr/(255.0f*100*100);
	g=cg/(255.0f*100*100);
	b=cb/(255.0f*100*100);
  // get the hue saturation and value (brightness)
  float ch,cs,cv;
  RGBtoHSV(r, g, b, &ch, &cs, &cv);
  h=ch; s=cs; v=cv;
  // don't bother with colours that aren't saturated enough or are too dark
  if(s>0.1 && v>0.1) {
    // get the closest match
    float minDistance = FLT_MAX;
    for(UIColor *colour in targetColours) {
      float targetHue, targetSat, targetValue;//, targetAlpha;
      // only available on iOS5
      //      [colour getHue:&targetHue saturation:&targetSat brightness:&targetValue alpha:&targetAlpha];
      const float *colourComponents = CGColorGetComponents(colour.CGColor);
      RGBtoHSV(colourComponents[0], colourComponents[1], colourComponents[2], &targetHue, &targetSat, &targetValue);
      // get the hues in radians
      float currentColourHueInRad = h * M_PI/180.0;
      float targetColourHueInRad = targetHue * M_PI/180.0;
      // compute the angular difference
      float difference = fabs(atan2(sin(currentColourHueInRad-targetColourHueInRad), cos(currentColourHueInRad-targetColourHueInRad))*180.0/M_PI);
      if(difference<minDistance) {
        minDistance = difference;
        closestColour = colour;
      }
    }  
  } else {
    // can't match the colours when the camera is looking at something very dark or very pale
    closestColour = nil;
  }
}

// do this on a timer as the captureOutput runs on it's own thread and can't update the UI
-(void) updateUI {
  // the raw RGB colour
  rgbColourView.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
  // the colour from the hue component ignoring the saturation and brighness components
  if(s>0.1 && v>0.1) {
    hueColourView.backgroundColor = [UIColor colorWithHue:h/360.0 saturation:1.0 brightness:1.0 alpha:1.0];
  } else {
    hueColourView.backgroundColor = [UIColor blackColor];
  }
  // set the closest colour
  closestColourView.backgroundColor = closestColour!=nil ? closestColour : [UIColor blackColor];
  infoLabel.text = [NSString stringWithFormat:@"RGB=%.f,%.f,%.f Hue=%.f Sat=%.2f Val=%.2f", r*255, g*255, b*255, h, s, v];
}

-(void) stopCameraCapture {
	[session stopRunning];
	[session release];
	session=nil;
}

- (void)dealloc {
  [previewView release];
  [rgbColourView release];
  [hueColourView release];
  [closestColourView release];
  [infoLabel release];
  [super dealloc];
}
@end
