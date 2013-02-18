//
//  saveFile.h
//  ColourDetector
//
//  Created by Steve Dye on 1/15/13.
//
//

#import <Foundation/Foundation.h>

@interface SaveFile : NSObject

@property (nonatomic, assign) int boxWidth;
@property (nonatomic, assign) int boxHeight;
@property (nonatomic, assign) int startingX;
@property (nonatomic, assign) int startingY;
@property (nonatomic, assign) BOOL focusLock;
@property (nonatomic, assign) BOOL exposureLock;
@property (nonatomic, assign) BOOL circleDraw;
@property (nonatomic, assign) NSString *fileName;

-(id) initWithSettings:(int) bw :(int) bh :(int) sx
:(int) sy :(BOOL) fl :(BOOL) el :(BOOL) cd :(NSString *)sn;



@end
