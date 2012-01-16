//
//  Target.m
//  ColourDetector
//
//  Created by Todd Steinackle on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Target.h"

@implementation Target

- (id)initWithCoder:(NSCoder *)decoder {
    rl = [decoder decodeIntForKey:@"rl"];
    rh = [decoder decodeIntForKey:@"rh"];
    gl = [decoder decodeIntForKey:@"gl"];
    gh = [decoder decodeIntForKey:@"gh"];
    bl = [decoder decodeIntForKey:@"bl"];
    bh = [decoder decodeIntForKey:@"bh"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:rl forKey:@"rl"];
    [encoder encodeInt:rh forKey:@"rh"];
    [encoder encodeInt:gl forKey:@"gl"];
    [encoder encodeInt:gh forKey:@"gh"];
    [encoder encodeInt:bl forKey:@"bl"];
    [encoder encodeInt:bh forKey:@"bh"];
}

@end
