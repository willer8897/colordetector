//
//  SettingsViewController.m
//  ColourDetector
//
//  Created by Todd Steinackle on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize selectionWidthTextField;
@synthesize selectionHeightTextField;
@synthesize startingXTextField;
@synthesize startingYTextField;
@synthesize exposureLock;
@synthesize focusLock;
@synthesize selectionWidth;
@synthesize selectionHeight;
@synthesize startingX;
@synthesize startingY;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
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

- (IBAction)dismiss {
    [appDelegate saveSettings];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
    [appDelegate setStartingCoordinates];
}

- (IBAction)exposureLockChanged:(UISwitch*)sender {
    appDelegate.exposureLock = sender.on;
}

- (IBAction)focusLockChanged:(UISwitch*)sender {
    appDelegate.focusLock = sender.on;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *s = [NSString stringWithFormat:@"%i", appDelegate.currentBoxWidth];
    selectionWidthTextField.text = s;
    s = [NSString stringWithFormat:@"%i", appDelegate.currentBoxHeight];
    selectionHeightTextField.text = s;
    s = [NSString stringWithFormat:@"%i", appDelegate.startingSelectionX];
    startingXTextField.text = s;
    s = [NSString stringWithFormat:@"%i", appDelegate.startingSelectionY];
    startingYTextField.text = s;
    exposureLock.on = appDelegate.exposureLock;
    focusLock.on = appDelegate.focusLock;
    if (appDelegate.viewController.isExposureLockSupported) {
        exposureLock.enabled = YES;
    } else {
        exposureLock.enabled = NO;
    }
    if (appDelegate.viewController.isFocusLockSupported) {
        focusLock.enabled = YES;
    } else {
        focusLock.enabled = NO;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSelectionWidthTextField:nil];
    [self setSelectionHeightTextField:nil];
    [self setStartingXTextField:nil];
    [self setStartingYTextField:nil];
    [super viewDidUnload];
}

- (void)dealloc
{
    [selectionWidth release];
    [selectionHeightTextField release];
    [startingXTextField release];
    [startingYTextField release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
