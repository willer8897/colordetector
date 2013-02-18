//
//  FilesTableViewController.h
//  ColourDetector
//
//  Created by Rob Wille on 1/16/13.
//
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@class ViewController;

@interface FilesTableViewController : UITableViewController
{
    AppDelegate *appDelegate;
    ViewController *vc;
}

- (NSArray *)getCellTitles;

@property (nonatomic, assign) NSArray *cellTitles;
@property (nonatomic, assign) int pressCount;
@property (nonatomic, strong) UINavigationBar *nav;


@end
