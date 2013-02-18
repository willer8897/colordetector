//
//  FilesTableViewController.m
//  ColourDetector
//
//  Created by Rob Wille on 1/16/13.
//
//

#import "FilesTableViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface FilesTableViewController ()

@end

@implementation FilesTableViewController

@synthesize cellTitles;
@synthesize pressCount;
@synthesize nav;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cellTitles = self.getCellTitles;
    appDelegate = [[UIApplication sharedApplication] delegate];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 1.5;
    [self.tableView addGestureRecognizer:longPress];
    [longPress release];
}

- (NSArray *)getCellTitles
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSArray *names = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:NULL];
    NSMutableArray *newNames = [[NSMutableArray alloc] init];
    [newNames addObject:@"Files:"];
    for(int i = 0; i < [names count]; i++)
    {
        NSString *currentString = [names objectAtIndex:i];
        NSString *fileExtension;
        if(currentString.length > 4)
            fileExtension = [currentString substringFromIndex:currentString.length-4];
        else
            fileExtension = currentString;
        if(![fileExtension isEqualToString:@".dat"])
            if(![currentString isEqualToString:@"Cancel Load"])
                if(![currentString isEqualToString:@""])
                    if(![currentString isEqualToString:@"colordetector.plist"])
                        if(![currentString isEqualToString:@"targetObjects.plist"])
                            [newNames addObject:currentString];
    }
    [newNames addObject:@"Cancel Load"];
    return newNames;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSString *fileName = [cellTitles objectAtIndex:indexPath.row];
    fileName = [fileName stringByReplacingOccurrencesOfString:@"colordetector" withString:@""];
    fileName = [fileName stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    cell.textLabel.text = fileName;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if([fileName isEqualToString:@"Files:"] || [fileName isEqualToString:@"Cancel Load"])
    {
        cell.textLabel.textColor = [UIColor blueColor];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSLog(@"Delete the file here");
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *settingsFilePath = [documentsDirectory stringByAppendingPathComponent:@"colordetector"];
        settingsFilePath = [settingsFilePath stringByAppendingString:alertView.title];
        NSString *targetFilePath = [settingsFilePath stringByAppendingString:@".dat"];
        settingsFilePath = [settingsFilePath stringByAppendingString:@".plist"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:settingsFilePath error:NULL];
        [fileManager removeItemAtPath:targetFilePath error:NULL];
        cellTitles = [self getCellTitles];
        [self.tableView reloadData];
        pressCount = 0;
    }
    if(buttonIndex == 1);
    {
        pressCount = 0;
        return;
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)press
{
    pressCount++;
    CGPoint p = [press locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if(indexPath.row == 0)
        return;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if([cell.textLabel.text isEqualToString:@"Cancel Load"])
        return;
    if(cell.textLabel.text == NULL)
        return;
    NSLog(@"Cell Selected: %@", cell.textLabel.text);
    UIAlertView *longPressAlert = [[UIAlertView alloc] initWithTitle:cell.textLabel.text message:@"Editing Save File" delegate:self cancelButtonTitle:@"Delete Save" otherButtonTitles:@"Cancel", nil];
    [longPressAlert setAlertViewStyle:UIAlertViewStyleDefault];
    if(pressCount == 1)
        [longPressAlert show];
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *fileSelected = cell.textLabel.text;
    if([fileSelected isEqualToString:@"Cancel Load"])
    {
        NSLog(@"Cancelling press");
        [self.tableView removeFromSuperview];
        [self.tableView release];
        return;
    }
    if([fileSelected isEqualToString:@"Files:"])
    {
        NSLog(@"Doing Nothing");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    NSLog(@"Loading file: %@", fileSelected);
    appDelegate.fileName = fileSelected;
    [appDelegate loadFileSettings:fileSelected];
    [appDelegate loadTargets];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [appDelegate setStartingCoordinates];
    [vc.selectionView setNeedsDisplay];
    [tableView removeFromSuperview];
}

@end
