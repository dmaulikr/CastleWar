//
//  ScrollingBackground.h
//  ScrollingSpriteKitTutorial
//
//  Created by Arthur Knopper on 16-03-14.
//  Copyright (c) 2014 Arthur Knopper. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScrollingBackground : SKSpriteNode

- (id)initWithBackground:(NSString *)background
                   frame:(CGRect)frame
                   speed:(CGFloat)speed;

- (void)update:(NSTimeInterval)currentTime;

@end

