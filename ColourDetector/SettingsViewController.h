//
//  SettingsViewController.h
//  ColourDetector
//
//  Created by Todd Steinackle on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface SettingsViewController : UIViewController <UITextFieldDelegate> {

    NSString *selectionWidth;
    NSString *selectionHeight;
    NSString *startingX;
    NSString *startingY;

    AppDelegate *appDelegate;
    IBOutlet UIScrollView *scrollView;

}

- (IBAction)dismiss;
- (IBAction)outputEnabledChanged:(UISwitch*)sender;
- (IBAction)lightEnabledChanged:(UISwitch*)sender;
- (IBAction)NONCChanged:(UISegmentedControl*)sender;
- (void)updateTargetTextFields:(NSArray *)sortedArray :(int)targetIndex;

@property (retain, nonatomic) IBOutlet UITextField *selectionWidthTextField;
@property (retain, nonatomic) IBOutlet UITextField *selectionHeightTextField;
@property (retain, nonatomic) IBOutlet UITextField *startingXTextField;
@property (retain, nonatomic) IBOutlet UITextField *startingYTextField;

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

@property (nonatomic, copy) NSString *selectionWidth;
@property (nonatomic, copy) NSString *selectionHeight;
@property (nonatomic, copy) NSString *startingX;
@property (nonatomic, copy) NSString *startingY;

@property (nonatomic, retain) UIView *scrollView;

@end
