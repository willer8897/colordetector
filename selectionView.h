//
//  selectionView.h
//  ColourDetector
//
//  Created by TODD STEINACKLE on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface selectionView : UIView {
    int pictureWidth;
    int pictureHeight;
    CGFloat heightScaleFactor;
    CGFloat widthScaleFactor;
    AppDelegate *appDelegate;
}

@end
