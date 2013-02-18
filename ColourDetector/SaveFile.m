//
//  saveFile.m
//  ColourDetector
//
//  Created by Rob Wille on 1/15/13.
//
//

#import "saveFile.h"

@implementation SaveFile

@synthesize boxWidth = _boxWidth;
@synthesize boxHeight = _boxHeight;
@synthesize startingX = _startingX;
@synthesize startingY = _startingY;
@synthesize focusLock = _focusLock;
@synthesize exposureLock = _exposureLock;
@synthesize circleDraw = _circleDraw;
@synthesize fileName = _fileName;

-(id)initWithSettings:(int)bw :(int)bh :(int)sx :(int)sy :(BOOL)fl :(BOOL)el :(BOOL)cd :(NSString *)sn
{
    _boxWidth = bw;
    _boxHeight = bh;
    _startingX = sx;
    _startingY = sy;
    _focusLock = fl;
    _exposureLock = el;
    _circleDraw = cd;
    _fileName = sn;
    return self;
}

@end
