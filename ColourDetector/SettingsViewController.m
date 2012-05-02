//
//  SettingsViewController.m
//  ColourDetector
//
//  Created by Todd Steinackle on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "Target.h"

@implementation SettingsViewController

@synthesize selectionWidthTextField;
@synthesize selectionHeightTextField;
@synthesize startingXTextField;
@synthesize startingYTextField;
@synthesize selectionWidth;
@synthesize selectionHeight;
@synthesize startingX;
@synthesize startingY;
@synthesize target1TextFields;
@synthesize target1Switch;
@synthesize target2TextFields;
@synthesize target2Switch;
@synthesize target3TextFields;
@synthesize target3Switch;
@synthesize target4TextFields;
@synthesize target4Switch;
@synthesize target5TextFields;
@synthesize target5Switch;
@synthesize target6TextFields;
@synthesize target6Switch;
@synthesize target7TextFields;
@synthesize target7Switch;
@synthesize target8TextFields;
@synthesize target8Switch;
@synthesize scrollView;
@synthesize target1Light;
@synthesize target2Light;
@synthesize target3Light;
@synthesize target4Light;
@synthesize target5Light;
@synthesize target6Light;
@synthesize target7Light;
@synthesize target8Light;


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

- (IBAction)lightEnabledChanged:(UISwitch*)sender {
    Target *target;
    if ([sender isEqual:target1Light]) {
        target = [appDelegate.targets objectAtIndex:0];
        target.light = sender.on;
    }
    if ([sender isEqual:target2Light]) {
        target = [appDelegate.targets objectAtIndex:1];
        target.light = sender.on;
    }
    if ([sender isEqual:target3Light]) {
        target = [appDelegate.targets objectAtIndex:2];
        target.light = sender.on;
    }
    if ([sender isEqual:target4Light]) {
        target = [appDelegate.targets objectAtIndex:3];
        target.light = sender.on;
    }
    if ([sender isEqual:target5Light]) {
        target = [appDelegate.targets objectAtIndex:4];
        target.light = sender.on;
    }
    if ([sender isEqual:target6Light]) {
        target = [appDelegate.targets objectAtIndex:5];
        target.light = sender.on;
    }
    if ([sender isEqual:target7Light]) {
        target = [appDelegate.targets objectAtIndex:6];
        target.light = sender.on;
    }
    if ([sender isEqual:target8Light]) {
        target = [appDelegate.targets objectAtIndex:7];
        target.light = sender.on;
    }
}

- (IBAction)outputEnabledChanged:(UISwitch*)sender {
    Target *target;
    if ([sender isEqual:target1Switch]) {
        target = [appDelegate.targets objectAtIndex:0];
        target.on = sender.on;
    }
    if ([sender isEqual:target2Switch]) {
        target = [appDelegate.targets objectAtIndex:1];
        target.on = sender.on;
    }
    if ([sender isEqual:target3Switch]) {
        target = [appDelegate.targets objectAtIndex:2];
        target.on = sender.on;
    }
    if ([sender isEqual:target4Switch]) {
        target = [appDelegate.targets objectAtIndex:3];
        target.on = sender.on;
    }
    if ([sender isEqual:target5Switch]) {
        target = [appDelegate.targets objectAtIndex:4];
        target.on = sender.on;
    }
    if ([sender isEqual:target6Switch]) {
        target = [appDelegate.targets objectAtIndex:5];
        target.on = sender.on;
    }
    if ([sender isEqual:target7Switch]) {
        target = [appDelegate.targets objectAtIndex:6];
        target.on = sender.on;
    }
    if ([sender isEqual:target8Switch]) {
        target = [appDelegate.targets objectAtIndex:7];
        target.on = sender.on;
    }
}

- (IBAction)dismiss {
    [appDelegate saveSettings];
    [appDelegate saveTargets];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
#ifdef DEBUG
    NSLog(@"object %@", self.presentingViewController);
#endif
    [appDelegate setStartingCoordinates];
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)updateTargetTextFields:(NSArray *)sortedArray :(int)targetIndex {
    Target *target = [appDelegate.targets objectAtIndex:targetIndex];
    int targetValues[6] = { target.rl, target.rh, target.gl, target.gh, target.bl, target.bh };
    for (int i = 0; i < [sortedArray count]; ++i) {
        NSString *s = [NSString stringWithFormat:@"%i", targetValues[i]];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
}

#pragma mark - View lifecycle

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

    int targetIndex = 0;
    Target *target = [appDelegate.targets objectAtIndex:targetIndex];
    target1Switch.on = target.on;
    target1Light.on = target.light;
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    NSArray *sortedArray = [target1TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target2Switch.on = target.on;
    target2Light.on = target.light;
    sortedArray = [target2TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target3Switch.on = target.on;
    target3Light.on = target.light;
    sortedArray = [target3TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target4Switch.on = target.on;
    target4Light.on = target.light;
    sortedArray = [target4TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target5Switch.on = target.on;
    target5Light.on = target.light;
    sortedArray = [target5TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target6Switch.on = target.on;
    target6Light.on = target.light;
    sortedArray = [target6TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target7Switch.on = target.on;
    target7Light.on = target.light;
    sortedArray = [target7TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target8Switch.on = target.on;
    target8Light.on = target.light;
    sortedArray = [target8TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollView.contentSize = CGSizeMake(320*9, 480);
    scrollView.pagingEnabled = YES;
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
