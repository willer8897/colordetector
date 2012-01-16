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
    [appDelegate saveSettings];
    [self dismiss];
    return YES;
}

- (IBAction)dismiss {
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

    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];

    NSArray *sortedArray = [target1TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
    sortedArray = [target2TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
    sortedArray = [target3TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
    sortedArray = [target4TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
    sortedArray = [target5TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
    sortedArray = [target6TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
    sortedArray = [target7TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
    sortedArray = [target8TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    for (int i = 0; i < [sortedArray count]; ++i) {
        s = [NSString stringWithFormat:@"%i", i];
        UITextField *temp = [sortedArray objectAtIndex:i];
        temp.text = s;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIScrollView *tempScrollView=(UIScrollView *)self.view;
    tempScrollView.contentSize=CGSizeMake(320,1370);
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
