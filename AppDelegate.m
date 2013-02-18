//
//  AppDelegate.m
//  ColourDetector
//
//  Created by Chris Greening on 06/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FilesTableViewController.h"
#import "ViewController.h"
#import "Target.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize currentBoxWidth;
@synthesize currentBoxHeight;
@synthesize startingSelectionX;
@synthesize startingSelectionY;
@synthesize targets;
@synthesize SCREEN_WIDTH_IN_POINTS;
@synthesize SCREEN_HEIGHT_IN_POINTS;
@synthesize exposureLock;
@synthesize focusLock;
@synthesize circleDraw;
@synthesize minorAxis;
@synthesize majorAxis;
@synthesize screenRect;
@synthesize fileName;



#pragma mark -

- (void)setStartingCoordinates
{
    if (startingSelectionX < currentBoxWidth/self.viewController.widthScaleFactor/2)
    {
        startingSelectionX = currentBoxWidth/self.viewController.widthScaleFactor/2-1;
#ifdef DEBUG
        NSLog(@"initial starting x was out of range");
#endif
    }
    self.viewController.selectionX = startingSelectionX;
    self.viewController.selectionY = startingSelectionY;
    self.viewController.selectionXimage = SCREEN_WIDTH_IN_POINTS - self.viewController.selectionX;
    
}

#pragma mark - archive/unarchive Targets

- (void)loadTargets
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSMutableData *targetObjects;
    NSKeyedUnarchiver *decoder;
    NSString *documentPath;
    
    if(fileName != nil && ![fileName isEqualToString:@""])
    {
        documentPath = [documentsDirectory stringByAppendingPathComponent:fileName];
        documentPath = [documentPath stringByAppendingString:@".dat"];
    }
    else
        documentPath = [documentsDirectory stringByAppendingPathComponent:@"targetObjects.dat"];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath])
    {
        NSLog(@"No target file found. Loading Default.");
        
    }
    NSLog(@"Loading from file: %@", documentPath);
    
    targetObjects = [NSData dataWithContentsOfFile:documentPath];

    decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:targetObjects];

    targets = [[decoder decodeObjectForKey:@"targets"] retain];
    
    NSLog(@"%@", targets);

	[decoder release];
}

- (void)updateTargets:(NSArray *)sortedArray :(int)target :(BOOL)enabled :(BOOL)lightEnabled :(int)NormOpenClosed :(float)onDelay :(float)offDelay
{
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

//consider adding a method here to update the targets without saving

- (void)saveTargets
{
    // update targets array
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    NSArray *sortedArray = [self.viewController.outputsViewController.target1TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    int target = 0;
    BOOL on = self.viewController.outputsViewController.target1Switch.on;
    BOOL light = self.viewController.outputsViewController.target1Light.on;
    int NoNc = self.viewController.outputsViewController.target1NONC.selectedSegmentIndex;
    float onDelay = [self.viewController.outputsViewController.target1OnDelay.text floatValue];
    float offDelay = [self.viewController.outputsViewController.target1OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.outputsViewController.target2TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.outputsViewController.target2Switch.on;
    light = self.viewController.outputsViewController.target2Light.on;
    NoNc = self.viewController.outputsViewController.target2NONC.selectedSegmentIndex;
    onDelay = [self.viewController.outputsViewController.target2OnDelay.text floatValue];
    offDelay = [self.viewController.outputsViewController.target2OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.outputsViewController.target3TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.outputsViewController.target3Switch.on;
    light = self.viewController.outputsViewController.target3Light.on;
    NoNc = self.viewController.outputsViewController.target3NONC.selectedSegmentIndex;
    onDelay = [self.viewController.outputsViewController.target3OnDelay.text floatValue];
    offDelay = [self.viewController.outputsViewController.target3OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.outputsViewController.target4TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.outputsViewController.target4Switch.on;
    light = self.viewController.outputsViewController.target4Light.on;
    NoNc = self.viewController.outputsViewController.target4NONC.selectedSegmentIndex;
    onDelay = [self.viewController.outputsViewController.target4OnDelay.text floatValue];
    offDelay = [self.viewController.outputsViewController.target4OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.outputsViewController.target5TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.outputsViewController.target5Switch.on;
    light = self.viewController.outputsViewController.target5Light.on;
    NoNc = self.viewController.outputsViewController.target5NONC.selectedSegmentIndex;
    onDelay = [self.viewController.outputsViewController.target5OnDelay.text floatValue];
    offDelay = [self.viewController.outputsViewController.target5OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.outputsViewController.target6TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.outputsViewController.target6Switch.on;
    light = self.viewController.outputsViewController.target6Light.on;
    NoNc = self.viewController.outputsViewController.target6NONC.selectedSegmentIndex;
    onDelay = [self.viewController.outputsViewController.target6OnDelay.text floatValue];
    offDelay = [self.viewController.outputsViewController.target6OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.outputsViewController.target7TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.outputsViewController.target7Switch.on;
    light = self.viewController.outputsViewController.target7Light.on;
    NoNc = self.viewController.outputsViewController.target7NONC.selectedSegmentIndex;
    onDelay = [self.viewController.outputsViewController.target7OnDelay.text floatValue];
    offDelay = [self.viewController.outputsViewController.target7OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

    sortedArray = [self.viewController.outputsViewController.target8TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    on = self.viewController.outputsViewController.target8Switch.on;
    light = self.viewController.outputsViewController.target8Light.on;
    NoNc = self.viewController.outputsViewController.target8NONC.selectedSegmentIndex;
    onDelay = [self.viewController.outputsViewController.target8OnDelay.text floatValue];
    offDelay = [self.viewController.outputsViewController.target8OffDelay.text floatValue];
    [self updateTargets:sortedArray :target++ :on :light :NoNc :onDelay :offDelay];

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *targetObjectsPath;
    if(fileName != nil && ![fileName isEqualToString:@""])
    {
        targetObjectsPath = [documentsDirectory stringByAppendingPathComponent:fileName];
        targetObjectsPath = [targetObjectsPath stringByAppendingString:@".dat"];
    }
    else
    {
        targetObjectsPath = [documentsDirectory stringByAppendingPathComponent:@"targetObjects.dat"];
    }
	NSMutableData *targetObjects;
	NSKeyedArchiver *encoder;
	targetObjects = [NSMutableData data];
	encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:targetObjects];

    [encoder encodeObject:targets forKey:@"targets"];

	[encoder finishEncoding];
    NSLog(@"Writing to file: %@",targetObjectsPath);
	[targetObjects writeToFile:targetObjectsPath atomically:YES];
	[encoder release];
#ifdef DEBUG_SETTINGS
    NSLog(@"%@", targets);
#endif
}

#pragma mark - Settings

- (void)loadFileSettings:(NSString *)fn
{
#ifdef DEBUG_SETTINGS
    NSLog(@"Loading settings from file: %@", fn);
#endif
    // initialize settings path every time
    [self initSettingsFilePath];
    fileName = fn;
    NSString *newSettingsFilePath;
    NSLog(@"Inside load. File name is %@", fileName);
    if(fn != nil && [fn length] > 0)
    {
        newSettingsFilePath = [settingsFilePath stringByAppendingString:fn];
        newSettingsFilePath = [newSettingsFilePath stringByAppendingString:@".plist"];
    }
    else
    {
        newSettingsFilePath = [settingsFilePath stringByAppendingString:@".plist"];
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:newSettingsFilePath])
    {
#ifdef DEBUG_SETTINGS
        NSLog(@"Found settings file");
#endif
        settings = [[NSMutableDictionary alloc] initWithContentsOfFile:newSettingsFilePath];
    }
    else
    {
#ifdef DEBUG_SETTINGS
        NSLog(@"No settings file, creating defaults");
#endif
        settings = [[NSMutableDictionary alloc] init];
        [settings setObject:[NSNumber numberWithInt:75] forKey:@"currentBoxWidth"];
        [settings setObject:[NSNumber numberWithInt:75] forKey:@"currentBoxHeight"];
        [settings setObject:[NSNumber numberWithInt:(SCREEN_WIDTH_IN_POINTS / 2)] forKey:@"startingSelectionX"];
        [settings setObject:[NSNumber numberWithInt:(SCREEN_HEIGHT_IN_POINTS / 2)] forKey:@"startingSelectionY"];
        [settings setObject:[NSNumber numberWithBool:FALSE] forKey:@"exposureLock"];
        [settings setObject:[NSNumber numberWithBool:FALSE] forKey:@"focusLock"];
        [settings setObject:[NSNumber numberWithBool:FALSE] forKey:@"circleDraw"];
        
    }
    
    
    // Get the settings from the settings dictionary
    self.currentBoxWidth = [[settings valueForKey:@"currentBoxWidth"] intValue];
    self.currentBoxHeight = [[settings valueForKey:@"currentBoxHeight"] intValue];
    self.startingSelectionX = [[settings valueForKey:@"startingSelectionX"] intValue];
    self.startingSelectionY = [[settings valueForKey:@"startingSelectionY"] intValue];
    self.exposureLock = [[settings valueForKey:@"exposureLock"] boolValue];
    self.focusLock = [[settings valueForKey:@"focusLock"] boolValue];
    self.circleDraw = [[settings valueForKey:@"circleDraw"] boolValue];
    
    //Update the controls to show the new settings
    self.viewController.selectionWidthTextField.text = [NSString stringWithFormat:@"%d", self.currentBoxWidth];
    self.viewController.selectionHeightTextField.text = [NSString stringWithFormat:@"%d", self.currentBoxHeight];
    self.viewController.startingXTextField.text = [NSString stringWithFormat:@"%d", self.startingSelectionX];
    self.viewController.startingYTextField.text = [NSString stringWithFormat:@"%d", self.startingSelectionY];
    self.viewController.exposureLock.enabled = self.exposureLock;
    self.viewController.focusLock.enabled = self.focusLock;
    if(circleDraw)
        self.viewController.drawSelector.selectedSegmentIndex = 1;
    if(!circleDraw)
        self.viewController.drawSelector.selectedSegmentIndex = 0;
    
    
    
#ifdef DEBUG_SETTINGS
    NSLog(@"currentBoxWidth=%i, currentBoxHeight=%i, startingSelectionX=%i, startingSelectionY=%i, exposureLock=%i, focusLock=%i", self.currentBoxWidth, self.currentBoxHeight, self.startingSelectionX , self.startingSelectionY, self.exposureLock, self.focusLock);
#endif
    
}

- (void)saveSettings
{
    // Save the current settings to the current file and update this delegate
    NSLog(@"Inside saveSettings. File Name is %@", fileName);
    
    NSNumber *w = [NSNumber numberWithFloat:[self.viewController.selectionWidthTextField.text intValue]];
    [settings setObject:w forKey:@"currentBoxWidth"];
    self.currentBoxWidth = [w intValue];

    NSNumber *h = [NSNumber numberWithFloat:[self.viewController.selectionHeightTextField.text intValue]];
    [settings setObject:h forKey:@"currentBoxHeight"];
    self.currentBoxHeight = [h intValue];

    NSNumber *x = [NSNumber numberWithInt:[self.viewController.startingXTextField.text intValue]];
    [settings setObject:x forKey:@"startingSelectionX"];
    self.startingSelectionX = [x intValue];

    NSNumber *y = [NSNumber numberWithInt:[self.viewController.startingYTextField.text intValue]];
    [settings setObject:y forKey:@"startingSelectionY"];
    self.startingSelectionY = [y intValue];

    NSNumber *exposure = [NSNumber numberWithBool:self.exposureLock];
    [settings setObject:exposure forKey:@"exposureLock"];

    NSNumber *focus = [NSNumber numberWithBool:self.focusLock];
    [settings setObject:focus forKey:@"focusLock"];
    
    NSNumber *drawSelection = [NSNumber numberWithBool:self.circleDraw];
    [settings setObject:drawSelection forKey:@"circleDraw"];
    
    settingsFilePath = [settingsFilePath stringByAppendingString:fileName];
    settingsFilePath = [settingsFilePath stringByAppendingString:@".plist"];
    [settings writeToFile:settingsFilePath atomically:YES];
#ifdef DEBUG_SETTINGS
    NSLog(@"Saving currentBoxWidth=%i, currentBoxHeight=%i, startingSelectionX=%i, startingSelectionY=%i, exposureLock=%i, focusLock=%i", [w intValue], [h intValue], [x intValue], [y intValue], [exposure boolValue], [focus boolValue]);
#endif
    

     
}

- (void)saveAsSettings:(NSString *)saveName
{
    // Save the current settings to the file and update this delegate
    fileName = saveName;
    NSLog(@"Inside saveAs. File Name is %@", fileName);
    
    NSNumber *w = [NSNumber numberWithFloat:[self.viewController.selectionWidthTextField.text intValue]];
    [settings setObject:w forKey:@"currentBoxWidth"];
    self.currentBoxWidth = [w intValue];
    
    NSNumber *h = [NSNumber numberWithFloat:[self.viewController.selectionHeightTextField.text intValue]];
    [settings setObject:h forKey:@"currentBoxHeight"];
    self.currentBoxHeight = [h intValue];
    
    NSNumber *x = [NSNumber numberWithInt:[self.viewController.startingXTextField.text intValue]];
    [settings setObject:x forKey:@"startingSelectionX"];
    self.startingSelectionX = [x intValue];
    
    NSNumber *y = [NSNumber numberWithInt:[self.viewController.startingYTextField.text intValue]];
    [settings setObject:y forKey:@"startingSelectionY"];
    self.startingSelectionY = [y intValue];
    
    NSNumber *exposure = [NSNumber numberWithBool:self.exposureLock];
    [settings setObject:exposure forKey:@"exposureLock"];
    
    NSNumber *focus = [NSNumber numberWithBool:self.focusLock];
    [settings setObject:focus forKey:@"focusLock"];
    
    NSNumber *drawSelection = [NSNumber numberWithBool:self.circleDraw];
    [settings setObject:drawSelection forKey:@"circleDraw"];
    
    
    NSString *newSettingsFilePath;
    newSettingsFilePath = [settingsFilePath stringByAppendingString:fileName];
    newSettingsFilePath = [newSettingsFilePath stringByAppendingString:@".plist"];
    //NSLog(@"File Name is: %@", newSettingsFilePath);
    [settings writeToFile:newSettingsFilePath atomically:YES];
    

#ifdef DEBUG_SETTINGS
    NSLog(@"Saving currentBoxWidth=%i, currentBoxHeight=%i, startingSelectionX=%i, startingSelectionY=%i, exposureLock=%i, focusLock=%i", [w intValue], [h intValue], [x intValue], [y intValue], [exposure boolValue], [focus boolValue]);
#endif
    
}


//gets all the saved files in the directory
- (NSArray *)getFileNames
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSArray *names = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:NULL];
    return names;
}


- (void)initSettingsFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    settingsFilePath = [documentsDirectory stringByAppendingPathComponent:@"colordetector"];
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
    fileName = @"targetObjects";
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    SCREEN_WIDTH_IN_POINTS = 320.0;
    SCREEN_HEIGHT_IN_POINTS = 480.0;
    screenRect = [[UIScreen mainScreen] bounds];

    [self loadTargets];
    if(targets == NULL || targets == nil)
    {
        targets = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; ++i)
        {
            Target *t = [[Target alloc] initWithTargetValues:0 :0 :0 :0 :0 :0 :YES :NO :0 :0.0 :0.0];
            [targets addObject:t];
        }
        [self saveTargets];
    }
    [self loadFileSettings:fileName];
    //fileName = @"";
#ifdef DEBUG
    NSLog(@"%@", targets);
#endif
    [self setStartingCoordinates];

    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveTargets];
}

@end
