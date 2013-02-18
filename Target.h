//
//  Target.h
//  ColourDetector
//
//  Created by Todd Steinackle on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target : NSObject <NSCoding>
{
    int rl, rh, gl, gh, bl, bh;
    BOOL on;
    BOOL light;
    int NoNc;
    float beforeDelayCounter, afterDelayCounter, beforeDelay, afterDelay;
    BOOL previousSample;
}

- (id)initWithTargetValues:(int)rMin :(int)rMax
                          :(int)gMin :(int)gMax
                          :(int)bMin :(int)bMax
                          :(BOOL)enabled
                          :(BOOL)lightEnabled
                          :(int)NormOpenClosed
                          :(float)beginningDelay
                          :(float)endingDelay;

- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;

@property (nonatomic, assign) int rl;
@property (nonatomic, assign) int rh;
@property (nonatomic, assign) int gl;
@property (nonatomic, assign) int gh;
@property (nonatomic, assign) int bl;
@property (nonatomic, assign) int bh;
@property (nonatomic, assign) BOOL on;
@property (nonatomic, assign) BOOL light;
@property (nonatomic, assign) int NoNc;
@property (nonatomic, assign) float beforeDelayCounter, afterDelayCounter, beforeDelay, afterDelay;
@property (nonatomic, assign) BOOL delaySet;
@property (nonatomic, assign) BOOL previousSample;

@end
