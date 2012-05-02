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


- (NSString *) description {
    return [NSString stringWithFormat:@"rl - %i, rh - %i, gl - %i, gh - %i, bl - %i, bh - %i, On - %i, Light - %i", rl, rh, gl, gh, bl, bh, on, light];
}

- (id)initWithTargetValues:(int)rMin :(int)rMax :(int)gMin :(int)gMax :(int)bMin :(int)bMax :(BOOL)enabled :(BOOL)lightEnabled {
    rl = rMin;
    rh = rMax;
    gl = gMin;
    gh = gMax;
    bl = bMin;
    bh = bMax;
    on = enabled;
    light = lightEnabled;
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    rl = [decoder decodeIntForKey:@"rl"];
    rh = [decoder decodeIntForKey:@"rh"];
    gl = [decoder decodeIntForKey:@"gl"];
    gh = [decoder decodeIntForKey:@"gh"];
    bl = [decoder decodeIntForKey:@"bl"];
    bh = [decoder decodeIntForKey:@"bh"];
    on = [decoder decodeBoolForKey:@"on"];
    light = [decoder decodeBoolForKey:@"light"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:rl forKey:@"rl"];
    [encoder encodeInt:rh forKey:@"rh"];
    [encoder encodeInt:gl forKey:@"gl"];
    [encoder encodeInt:gh forKey:@"gh"];
    [encoder encodeInt:bl forKey:@"bl"];
    [encoder encodeInt:bh forKey:@"bh"];
    [encoder encodeBool:on forKey:@"on"];
    [encoder encodeBool:light forKey:@"light"];
}

@end
