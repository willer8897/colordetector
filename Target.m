//
//  Target.m
//  ColourDetector
//
//  Created by Todd Steinackle on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Target.h"

@implementation Target

@synthesize rl;
@synthesize rh;
@synthesize gl;
@synthesize gh;
@synthesize bl;
@synthesize bh;
@synthesize on;
@synthesize light;
@synthesize NoNc;
@synthesize beforeDelayCounter, afterDelayCounter, beforeDelay, afterDelay;
@synthesize delaySet;
@synthesize previousSample;


- (NSString *) description
{
    return [NSString stringWithFormat:@"rl - %i, rh - %i, gl - %i, gh - %i, bl - %i, bh - %i, On - %i, Light - %i, NoNc - %i, beforeDelay -- %f, afterDelay -- %f", rl, rh, gl, gh, bl, bh, on, light, NoNc, beforeDelay, afterDelay];
}

- (id)initWithTargetValues:(int)rMin :(int)rMax :(int)gMin :(int)gMax :(int)bMin :(int)bMax
                          :(BOOL)enabled
                          :(BOOL)lightEnabled
                          :(int)NormOpenClosed
                          :(float)beginningDelay
                          :(float)endingDelay
{
    rl = rMin;
    rh = rMax;
    gl = gMin;
    gh = gMax;
    bl = bMin;
    bh = bMax;
    on = enabled;
    light = lightEnabled;
    NoNc = NormOpenClosed;
    beforeDelay = beginningDelay;
    afterDelay = endingDelay;

    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    rl = [decoder decodeIntForKey:@"rl"];
    rh = [decoder decodeIntForKey:@"rh"];
    gl = [decoder decodeIntForKey:@"gl"];
    gh = [decoder decodeIntForKey:@"gh"];
    bl = [decoder decodeIntForKey:@"bl"];
    bh = [decoder decodeIntForKey:@"bh"];
    on = [decoder decodeBoolForKey:@"on"];
    light = [decoder decodeBoolForKey:@"light"];
    NoNc = [decoder decodeIntForKey:@"NoNc"];
    beforeDelay = [decoder decodeFloatForKey:@"beforeDelay"];
    afterDelay = [decoder decodeFloatForKey:@"afterDelay"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:rl forKey:@"rl"];
    [encoder encodeInt:rh forKey:@"rh"];
    [encoder encodeInt:gl forKey:@"gl"];
    [encoder encodeInt:gh forKey:@"gh"];
    [encoder encodeInt:bl forKey:@"bl"];
    [encoder encodeInt:bh forKey:@"bh"];
    [encoder encodeBool:on forKey:@"on"];
    [encoder encodeBool:light forKey:@"light"];
    [encoder encodeInt:NoNc forKey:@"NoNc"];
    [encoder encodeFloat:beforeDelay forKey:@"beforeDelay"];
    [encoder encodeFloat:afterDelay forKey:@"afterDelay"];
}

@end
