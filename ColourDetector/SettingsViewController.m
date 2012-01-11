//
//  SettingsViewController.m
//  ColourDetector
//
//  Created by Todd Steinackle on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@implementation SettingsViewController

@synthesize selectionWidthTextField;
@synthesize selectionHeightTextField;
@synthesize startingXTextField;
@synthesize startingYTextField;
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
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
#ifdef DEBUG
    NSLog(@"object %@", self.presentingViewController);
#endif
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [selectionWidth release];
    [selectionHeightTextField release];
    [startingXTextField release];
    [startingYTextField release];
    [super dealloc];
}
@end
