//
//  Monster.m
//  GoalingBall
//
//  Created by GrepRuby on 29/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import "Monster.h"

@implementation Monster


- (instancetype)initWithPosition:(CGPoint)position withBackgroungTexture:(SKTexture *)textureBg {

    if(self = [super initWithPosition:position withBackgroungTexture:nil]) {

        self = [self initWithImageNamed:@"monster"];
        [self addMonsterWithPosition:position];
    }
    return self;
}

#pragma mark- Add monster

- (void)addMonsterWithPosition:(CGPoint)position {

    // Create sprite
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 20)];
    self.physicsBody.dynamic = NO;
    self.name = @"Monster";
    self.physicsBody.categoryBitMask =  monsterCategory;
    self.physicsBody.contactTestBitMask =  RichterCategory;
    self.physicsBody.usesPreciseCollisionDetection = YES;

    // and along a random position along the Y axis as calculated above
    self.position = CGPointMake(position.x, position.y);
}

- (void)walkZombiewithXAxis:(CGFloat)startPoint toEndPoint:(CGFloat)endPoint {

    // in the first animation CapGuy walks from left to right, in the second one he turns from right to left
    SKAction *walk = [SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"monster"]]  timePerFrame:0.8];

    SKAction *walkAnim = [SKAction sequence:@[walk, walk, walk]];
    SKAction *moveRight  = [SKAction moveToX:startPoint duration:walkAnim.duration];
    SKAction *moveLeft   = [SKAction moveToX:endPoint duration:walkAnim.duration];

    // to get a mirrored animation.
    SKAction *mirrorDirection  = [SKAction scaleXTo:-1 y:1 duration:0.0];
    SKAction *resetDirection   = [SKAction scaleXTo:1  y:1 duration:0.0];

    // Action within a group are executed in parallel:
    SKAction *walkAndMoveRight = [SKAction group:@[resetDirection,  walkAnim, moveRight]];
    SKAction *walkAndMoveLeft  = [SKAction group:@[mirrorDirection, walkAnim, moveLeft]];

    // now we combine the walk+turn actions into a sequence, and repeat it forever

    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[walkAndMoveRight, walkAndMoveLeft]]]];
}

@end
