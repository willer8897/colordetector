//
//  AppDelegate.m
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "Target.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize heightScaleFactor;
@synthesize widthScaleFactor;
@synthesize currentBoxWidth;
@synthesize currentBoxHeight;
@synthesize startingSelectionX;
@synthesize startingSelectionY;
@synthesize targets;
@synthesize SCREEN_WIDTH_IN_POINTS;
@synthesize SCREEN_HEIGHT_IN_POINTS;
@synthesize exposureLock;
@synthesize focusLock;

#pragma mark -

- (void)setStartingCoordinates {
    if (startingSelectionX < currentBoxWidth/widthScaleFactor/2) {
        startingSelectionX = currentBoxWidth/widthScaleFactor/2-1;
#ifdef DEBUG
        NSLog(@"initial starting x was out of range");
#endif
    }
    self.viewController.selectionX = startingSelectionX + (currentBoxWidth/2);
    self.viewController.selectionY = startingSelectionY - (currentBoxHeight/2);
    self.viewController.selectionXimage = SCREEN_WIDTH_IN_POINTS - self.viewController.selectionX;
}

#pragma mark - archive/unarchive Targets

- (void)loadTargets {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSMutableData *targetObjects;
    NSKeyedUnarchiver *decoder;

    NSString *documentPath = [documentsDirectory stringByAppendingPathComponent:@"targetObjects.dat"];

    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
        NSLog(@"Targets archive file doesn't exist.");
        return;
    }
    targetObjects = [NSData dataWithContentsOfFile:documentPath];

    decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:targetObjects];

    targets = [[decoder decodeObjectForKey:@"targets"] retain];

	[decoder release];
}

- (void)updateTargets:(NSArray *)sortedArray :(int)target :(BOOL)enabled :(BOOL)lightEnabled :(int)NormOpenClosed :(float)onDelay :(float)offDelay {
    Target *t = [targets objectAtIndex:target];
    UITextField *textField = [sortedArray objectAtIndex:0];
    t.rl = [textField.text intValue];
    textField = [sortedArray objectAtIndex:1];
    t.rh = [textField.text intValue];
    textField = [sortedArray objectAtIndex:2];
    t.gl = [textField.text intValue];
    textField = [sortedArray objectAtIndex:3];
    t.gh = [textField.text intValue];
    textField = [sortedArray objectAtIndex:4];
    t.bl = [textField.text intValue];
    textField = [sortedArray objectAtIndex:5];
    t.bh = [textField.text intValue];

    t.on = enabled;
    t.light = lightEnabled;
    t.NoNc = NormOpenClosed;
    t.beforeDelay = onDelay;
    t.afterDelay = offDelay;
}

- (void)saveTargets {
    // update targets array
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    NSArray *sortedArray = [self.viewController.settingsViewController.target1TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    int target = 0;
    BOOL on = self.viewController.settingsViewController.target1Switch.on;
    BOOL light = self.viewController.settingsViewController.target1Light.on;
    int NoNc = self.viewController.settingsViewController.target1NONC.selectedSegmentIndex;
    float onDelay = [self.viewController.settingsViewController.target1OnDelay.text floatValue];
    float offDelay = [self.viewController.settingsViewController.target1OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.settingsViewController.target2TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.settingsViewController.target2Switch.on;
    light = self.viewController.settingsViewController.target2Light.on;
    NoNc = self.viewController.settingsViewController.target2NONC.selectedSegmentIndex;
    onDelay = [self.viewController.settingsViewController.target2OnDelay.text floatValue];
    offDelay = [self.viewController.settingsViewController.target2OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.settingsViewController.target3TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.settingsViewController.target3Switch.on;
    light = self.viewController.settingsViewController.target3Light.on;
    NoNc = self.viewController.settingsViewController.target3NONC.selectedSegmentIndex;
    onDelay = [self.viewController.settingsViewController.target3OnDelay.text floatValue];
    offDelay = [self.viewController.settingsViewController.target3OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.settingsViewController.target4TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.settingsViewController.target4Switch.on;
    light = self.viewController.settingsViewController.target4Light.on;
    NoNc = self.viewController.settingsViewController.target4NONC.selectedSegmentIndex;
    onDelay = [self.viewController.settingsViewController.target4OnDelay.text floatValue];
    offDelay = [self.viewController.settingsViewController.target4OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.settingsViewController.target5TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.settingsViewController.target5Switch.on;
    light = self.viewController.settingsViewController.target5Light.on;
    NoNc = self.viewController.settingsViewController.target5NONC.selectedSegmentIndex;
    onDelay = [self.viewController.settingsViewController.target5OnDelay.text floatValue];
    offDelay = [self.viewController.settingsViewController.target5OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.settingsViewController.target6TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.settingsViewController.target6Switch.on;
    light = self.viewController.settingsViewController.target6Light.on;
    NoNc = self.viewController.settingsViewController.target6NONC.selectedSegmentIndex;
    onDelay = [self.viewController.settingsViewController.target6OnDelay.text floatValue];
    offDelay = [self.viewController.settingsViewController.target6OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.settingsViewController.target7TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.settingsViewController.target7Switch.on;
    light = self.viewController.settingsViewController.target7Light.on;
    NoNc = self.viewController.settingsViewController.target7NONC.selectedSegmentIndex;
    onDelay = [self.viewController.settingsViewController.target7OnDelay.text floatValue];
    offDelay = [self.viewController.settingsViewController.target7OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.settingsViewController.target8TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.settingsViewController.target8Switch.on;
    light = self.viewController.settingsViewController.target8Light.on;
    NoNc = self.viewController.settingsViewController.target8NONC.selectedSegmentIndex;
    onDelay = [self.viewController.settingsViewController.target8OnDelay.text floatValue];
    offDelay = [self.viewController.settingsViewController.target8OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *targetObjectsPath = [documentsDirectory stringByAppendingPathComponent:@"targetObjects.dat"];

	NSMutableData *targetObjects;
	NSKeyedArchiver *encoder;
	targetObjects = [NSMutableData data];
	encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:targetObjects];

    [encoder encodeObject:targets forKey:@"targets"];

	[encoder finishEncoding];
	[targetObjects writeToFile:targetObjectsPath atomically:YES];
	[encoder release];
#ifdef DEBUG
    NSLog(@"%@", targets);
#endif
}

#pragma mark - Settings

- (void)loadSettings {
#ifdef DEBUG
    NSLog(@"Loading settings.");
#endif
    // If the settings file has not been initialized then initialize
    if(settingsFilePath == nil)
        [self initSettingsFilePath];

    // If the settings file cannot be found then create it with default values
    if([[NSFileManager defaultManager] fileExistsAtPath:settingsFilePath]) {
#ifdef DEBUG
        NSLog(@"Found settings file");
#endif
        settings = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsFilePath];
    } else {
#ifdef DEBUG
        NSLog(@"No settings file, creating defaults");
#endif
        settings = [[NSMutableDictionary alloc] init];
        [settings setObject:[NSNumber numberWithInt:75] forKey:@"currentBoxWidth"];
        [settings setObject:[NSNumber numberWithInt:75] forKey:@"currentBoxHeight"];
        [settings setObject:[NSNumber numberWithInt:(SCREEN_WIDTH_IN_POINTS / 2)] forKey:@"startingSelectionX"];
        [settings setObject:[NSNumber numberWithInt:(SCREEN_HEIGHT_IN_POINTS / 2)] forKey:@"startingSelectionY"];
        [settings setObject:[NSNumber numberWithBool:FALSE] forKey:@"exposureLock"];
        [settings setObject:[NSNumber numberWithBool:FALSE] forKey:@"focusLock"];
    }

    // Get the settings from the settings dictionary
    self.currentBoxWidth = [[settings valueForKey:@"currentBoxWidth"] intValue];
    self.currentBoxHeight = [[settings valueForKey:@"currentBoxHeight"] intValue];
    self.startingSelectionX = [[settings valueForKey:@"startingSelectionX"] intValue];
    self.startingSelectionY = [[settings valueForKey:@"startingSelectionY"] intValue];
    self.exposureLock = [[settings valueForKey:@"exposureLock"] boolValue];
    self.focusLock = [[settings valueForKey:@"focusLock"] boolValue];

}

- (void)saveSettings {
    // Save the current settings to the file and update this delegate
    NSNumber *w = [NSNumber numberWithFloat:[self.viewController.settingsViewController.selectionWidthTextField.text intValue]];
    [settings setObject:w forKey:@"currentBoxWidth"];
    self.currentBoxWidth = [w intValue];

    NSNumber *h = [NSNumber numberWithFloat:[self.viewController.settingsViewController.selectionHeightTextField.text intValue]];
    [settings setObject:h forKey:@"currentBoxHeight"];
    self.currentBoxHeight = [h intValue];

    NSNumber *x = [NSNumber numberWithInt:[self.viewController.settingsViewController.startingXTextField.text intValue]];
    [settings setObject:x forKey:@"startingSelectionX"];
    self.startingSelectionX = [x intValue];

    NSNumber *y = [NSNumber numberWithInt:[self.viewController.settingsViewController.startingYTextField.text intValue]];
    [settings setObject:y forKey:@"startingSelectionY"];
    self.startingSelectionY = [y intValue];


    [settings writeToFile:settingsFilePath atomically:YES];
#ifdef DEBUG
    NSLog(@"Saving currentBoxWidth=%i, currentBoxHeight=%i, startingSelectionX=%i, startingSelectionY=%i", [w intValue], [h intValue], [x intValue], [y intValue]);
#endif
}

- (void)initSettingsFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    settingsFilePath = [documentsDirectory stringByAppendingPathComponent:@"colordetector.plist"];
    [settingsFilePath retain];
}

#pragma mark - App lifecycle

- (void)dealloc
{
    [targets release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    SCREEN_WIDTH_IN_POINTS = 320.0;
    SCREEN_HEIGHT_IN_POINTS = 480.0;

#ifdef DEBUG
    NSLog(@"pixelBufferWidth - %d", self.viewController.pixelBufferWidth);
    NSLog(@"pixelBufferHeight - %d", self.viewController.pixelBufferHeight);
#endif

    heightScaleFactor = self.viewController.pixelBufferHeight / SCREEN_HEIGHT_IN_POINTS;
    widthScaleFactor = self.viewController.pixelBufferWidth / SCREEN_WIDTH_IN_POINTS;

#ifdef DEBUG
    NSLog(@"heightScaleFactor - %f", heightScaleFactor);
    NSLog(@"widthScaleFactor - %f", widthScaleFactor);
#endif

    targets = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; ++i) {
        Target *t = [[Target alloc] initWithTargetValues:0 :0 :0 :0 :0 :0 :YES :NO :0 :0.0 :0.0];
        [targets addObject:t];
    }
    [self loadSettings];
    [self loadTargets];
#ifdef DEBUG
    NSLog(@"%@", targets);
#endif
    [self setStartingCoordinates];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
    [self saveTargets];
}

@end
