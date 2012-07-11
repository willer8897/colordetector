//
//  OutputsViewController.h
//  ColourDetector
//
//  Created by Todd Steinackle on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface OutputsViewController : UIViewController <UITextFieldDelegate> {

    AppDelegate *appDelegate;
    IBOutlet UIScrollView *scrollView;
    UITextField *activeField;
    CGPoint originalPoint;
    BOOL editingTargetTextFields;

}

- (IBAction)dismiss;
- (IBAction)outputEnabledChanged:(UISwitch*)sender;
- (IBAction)lightEnabledChanged:(UISwitch*)sender;
- (IBAction)NONCChanged:(UISegmentedControl*)sender;
- (void)updateTargetTextFields:(NSArray *)sortedArray :(int)targetIndex;


// The text fields which hold the maximum and minimum RGB values (targets) are IBOutletCollections
// they are tagged with numbers in Interface Builder and then sorted before being used to ensure
// accessing them in the proper order
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target1TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target1Switch;
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target2TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target2Switch;
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target3TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target3Switch;
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target4TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target4Switch;
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target5TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target5Switch;
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target6TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target6Switch;
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target7TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target7Switch;
@property (nonatomic, retain) IBOutletCollection(UITextField) NSArray *target8TextFields;
@property (retain, nonatomic) IBOutlet UISwitch *target8Switch;

@property (retain, nonatomic) IBOutlet UISwitch *target1Light;
@property (retain, nonatomic) IBOutlet UISwitch *target2Light;
@property (retain, nonatomic) IBOutlet UISwitch *target3Light;
@property (retain, nonatomic) IBOutlet UISwitch *target4Light;
@property (retain, nonatomic) IBOutlet UISwitch *target5Light;
@property (retain, nonatomic) IBOutlet UISwitch *target6Light;
@property (retain, nonatomic) IBOutlet UISwitch *target7Light;
@property (retain, nonatomic) IBOutlet UISwitch *target8Light;

@property (retain, nonatomic) IBOutlet UISegmentedControl *target1NONC;
@property (retain, nonatomic) IBOutlet UISegmentedControl *target2NONC;
@property (retain, nonatomic) IBOutlet UISegmentedControl *target3NONC;
@property (retain, nonatomic) IBOutlet UISegmentedControl *target4NONC;
@property (retain, nonatomic) IBOutlet UISegmentedControl *target5NONC;
@property (retain, nonatomic) IBOutlet UISegmentedControl *target6NONC;
@property (retain, nonatomic) IBOutlet UISegmentedControl *target7NONC;
@property (retain, nonatomic) IBOutlet UISegmentedControl *target8NONC;

@property (retain, nonatomic) IBOutlet UITextField *target1OnDelay;
@property (retain, nonatomic) IBOutlet UITextField *target2OnDelay;
@property (retain, nonatomic) IBOutlet UITextField *target3OnDelay;
@property (retain, nonatomic) IBOutlet UITextField *target4OnDelay;
@property (retain, nonatomic) IBOutlet UITextField *target5OnDelay;
@property (retain, nonatomic) IBOutlet UITextField *target6OnDelay;
@property (retain, nonatomic) IBOutlet UITextField *target7OnDelay;
@property (retain, nonatomic) IBOutlet UITextField *target8OnDelay;

@property (retain, nonatomic) IBOutlet UITextField *target1OffDelay;
@property (retain, nonatomic) IBOutlet UITextField *target2OffDelay;
@property (retain, nonatomic) IBOutlet UITextField *target3OffDelay;
@property (retain, nonatomic) IBOutlet UITextField *target4OffDelay;
@property (retain, nonatomic) IBOutlet UITextField *target5OffDelay;
@property (retain, nonatomic) IBOutlet UITextField *target6OffDelay;
@property (retain, nonatomic) IBOutlet UITextField *target7OffDelay;
@property (retain, nonatomic) IBOutlet UITextField *target8OffDelay;

@property (nonatomic, retain) UIView *scrollView;

@end
