//
//  Monster.m
//  GoalingBall
//
//  Created by GrepRuby on 29/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import "Star.h"

@implementation Star

- (instancetype)initWithPosition:(CGPoint)position withBackgroungTexture:(SKTexture *)textureBg {

    if(self = [super initWithPosition:position withBackgroungTexture:nil]) {

        self = [self initWithImageNamed:@"star"];
        [self addMonsterWithPosition:position];
    }
    return self;
}

#pragma mark- Add monster

- (void)addMonsterWithPosition:(CGPoint)position {

    // Create sprite
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.name = @"star";
    self.physicsBody.categoryBitMask =  starCategory;
    self.physicsBody.contactTestBitMask =  RichterCategory;
    self.physicsBody.usesPreciseCollisionDetection = YES;

    // and along a random position along the Y axis as calculated above
    self.position = CGPointMake(position.x, position.y);
}

@end
