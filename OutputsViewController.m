//
//  OutputsViewController.m
//  ColourDetector
//
//  Created by Todd Steinackle on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OutputsViewController.h"
#import "AppDelegate.h"
#import "Target.h"
#import "ViewController.h"

@implementation OutputsViewController

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
@synthesize target1NONC;
@synthesize target2NONC;
@synthesize target3NONC;
@synthesize target4NONC;
@synthesize target5NONC;
@synthesize target6NONC;
@synthesize target7NONC;
@synthesize target8NONC;
@synthesize target1OnDelay;
@synthesize target2OnDelay;
@synthesize target3OnDelay;
@synthesize target4OnDelay;
@synthesize target5OnDelay;
@synthesize target6OnDelay;
@synthesize target7OnDelay;
@synthesize target8OnDelay;
@synthesize target1OffDelay;
@synthesize target2OffDelay;
@synthesize target3OffDelay;
@synthesize target4OffDelay;
@synthesize target5OffDelay;
@synthesize target6OffDelay;
@synthesize target7OffDelay;
@synthesize target8OffDelay;

#pragma mark - UI update methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (IBAction)NONCChanged:(UISegmentedControl*)sender {
    Target *target;
    if ([sender isEqual:target1NONC]) {
        target = [appDelegate.targets objectAtIndex:0];
        target.NoNc = sender.selectedSegmentIndex;
    }
    if ([sender isEqual:target2NONC]) {
        target = [appDelegate.targets objectAtIndex:1];
        target.NoNc = sender.selectedSegmentIndex;
    }
    if ([sender isEqual:target3NONC]) {
        target = [appDelegate.targets objectAtIndex:2];
        target.NoNc = sender.selectedSegmentIndex;
    }
    if ([sender isEqual:target4NONC]) {
        target = [appDelegate.targets objectAtIndex:3];
        target.NoNc = sender.selectedSegmentIndex;
    }
    if ([sender isEqual:target5NONC]) {
        target = [appDelegate.targets objectAtIndex:4];
        target.NoNc = sender.selectedSegmentIndex;
    }
    if ([sender isEqual:target6NONC]) {
        target = [appDelegate.targets objectAtIndex:5];
        target.NoNc = sender.selectedSegmentIndex;
    }
    if ([sender isEqual:target7NONC]) {
        target = [appDelegate.targets objectAtIndex:6];
        target.NoNc = sender.selectedSegmentIndex;
    }
    if ([sender isEqual:target8NONC]) {
        target = [appDelegate.targets objectAtIndex:7];
        target.NoNc = sender.selectedSegmentIndex;
    }
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

- (IBAction)dismiss
{
    NSString *text = @"Save targets to: ";
    text = [text stringByAppendingString:appDelegate.fileName];
    text = [text stringByAppendingString:@" ?"];
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Save Targets" message:text delegate:self cancelButtonTitle:@"Save" otherButtonTitles:@"Don't Save" , nil];
    saveAlert.alertViewStyle = UIAlertViewStyleDefault;
    [saveAlert show];
    //dismiss the vc inside alert view handling
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Inside Alert View. File Name is %@", appDelegate.fileName);
    if(buttonIndex == 0)
    {
        [appDelegate saveTargets];
        [appDelegate saveAsSettings:appDelegate.fileName];
        [self.presentingViewController dismissModalViewControllerAnimated:YES];
        return;
    }
    /*
    if(buttonIndex == 1)
    {
        NSString *saveName = [[alertView textFieldAtIndex:0] text];
        appDelegate.fileName = saveName;
        
    }
     */
    if(buttonIndex == 1)
    {
        [appDelegate loadTargets];
        [self.presentingViewController dismissModalViewControllerAnimated:YES];
        return;
    }
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

#pragma mark - keyboard handling

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];

}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    scrollView.scrollEnabled = NO;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (editingTargetTextFields) {
        [scrollView setContentOffset:originalPoint animated:YES];
    }
    editingTargetTextFields = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    if (!editingTargetTextFields) {
        originalPoint = CGPointMake(0.0, scrollView.contentOffset.y);
        CGPoint scrollPoint;
        if (activeField == target1OnDelay || activeField == target1OffDelay ||
            activeField == target2OnDelay || activeField == target2OffDelay ||
            activeField == target3OnDelay || activeField == target3OffDelay ||
            activeField == target4OnDelay || activeField == target4OffDelay ||
            activeField == target5OnDelay || activeField == target5OffDelay ||
            activeField == target6OnDelay || activeField == target6OffDelay ||
            activeField == target7OnDelay || activeField == target7OffDelay ||
            activeField == target8OnDelay || activeField == target8OffDelay) {
            scrollPoint = CGPointMake(0.0, scrollView.contentOffset.y + 205.0);
        } else {
            scrollPoint = CGPointMake(0.0, scrollView.contentOffset.y + 170.0);
        }
        [scrollView setContentOffset:scrollPoint animated:YES];
        editingTargetTextFields = YES;
        scrollView.pagingEnabled = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.view setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:217.0/255.0 blue:223.0/255.0 alpha:1.0]];

    CGPoint scrollPoint = CGPointMake(0.0, 480.0 * (appDelegate.viewController.outputScreen-1));
    [scrollView setContentOffset:scrollPoint animated:YES];

    int targetIndex = 0;
    Target *target = [appDelegate.targets objectAtIndex:targetIndex];
    target1Switch.on = target.on;
    target1Light.on = target.light;
    target1NONC.selectedSegmentIndex = target.NoNc;
    NSString *s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target1OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target1OffDelay.text = s;
    NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    NSArray *sortedArray = [target1TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target2Switch.on = target.on;
    target2Light.on = target.light;
    target2NONC.selectedSegmentIndex = target.NoNc;
    s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target2OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target2OffDelay.text = s;
    sortedArray = [target2TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target3Switch.on = target.on;
    target3Light.on = target.light;
    target3NONC.selectedSegmentIndex = target.NoNc;
    s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target3OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target3OffDelay.text = s;
    sortedArray = [target3TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target4Switch.on = target.on;
    target4Light.on = target.light;
    target4NONC.selectedSegmentIndex = target.NoNc;
    s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target4OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target4OffDelay.text = s;
    sortedArray = [target4TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target5Switch.on = target.on;
    target5Light.on = target.light;
    target5NONC.selectedSegmentIndex = target.NoNc;
    s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target5OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target5OffDelay.text = s;
    sortedArray = [target5TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target6Switch.on = target.on;
    target6Light.on = target.light;
    target6NONC.selectedSegmentIndex = target.NoNc;
    s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target6OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target6OffDelay.text = s;
    sortedArray = [target6TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target7Switch.on = target.on;
    target7Light.on = target.light;
    target7NONC.selectedSegmentIndex = target.NoNc;
    s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target7OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target7OffDelay.text = s;
    sortedArray = [target7TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];

    target = [appDelegate.targets objectAtIndex:targetIndex];
    target8Switch.on = target.on;
    target8Light.on = target.light;
    target8NONC.selectedSegmentIndex = target.NoNc;
    s = [NSString stringWithFormat:@"%1.1f", target.beforeDelay];
    target8OnDelay.text = s;
    s = [NSString stringWithFormat:@"%1.1f", target.afterDelay];
    target8OffDelay.text = s;
    sortedArray = [target8TextFields sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
    [self updateTargetTextFields:sortedArray :targetIndex++];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollView.contentSize = CGSizeMake(appDelegate.SCREEN_WIDTH_IN_POINTS, 
                                        appDelegate.SCREEN_HEIGHT_IN_POINTS*8);
    scrollView.pagingEnabled = YES;
    [self registerForKeyboardNotifications];
    //change back to load?
    //[appDelegate loadTargets];
    //[appDelegate saveTargets];
    NSLog(@"File name is ---> %@", appDelegate.fileName);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
}
@end
