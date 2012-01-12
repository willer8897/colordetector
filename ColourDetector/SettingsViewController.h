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
}

- (IBAction)dismiss;

@property (retain, nonatomic) IBOutlet UITextField *selectionWidthTextField;
@property (retain, nonatomic) IBOutlet UITextField *selectionHeightTextField;
@property (retain, nonatomic) IBOutlet UITextField *startingXTextField;
@property (retain, nonatomic) IBOutlet UITextField *startingYTextField;


@property (nonatomic, copy) NSString *selectionWidth;
@property (nonatomic, copy) NSString *selectionHeight;
@property (nonatomic, copy) NSString *startingX;
@property (nonatomic, copy) NSString *startingY;

@end
