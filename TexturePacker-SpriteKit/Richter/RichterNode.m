//
//  Richter.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "RichterNode.h"
#import "richter.h"

@implementation RichterNode

- (instancetype)initWithPosition:(CGPoint)position withBackgroungTexture:(SKTexture *)textureBg {

    if(self = [super initWithPosition:position withBackgroungTexture:nil]) {

        atlas = [SKTextureAtlas atlasNamed:RICHTER_ATLAS_NAME];
        self = [self initWithTexture:RICHTER_WALK_0001];
        [self addRichterPosition:position];
    }
    return self;
}

#pragma mark- Add monster

- (void)addRichterPosition:(CGPoint)posit {

    self.position = posit;//
    [self runAction:[SKAction scaleTo:3 duration:0.0]];
        //self.zPosition = 1;
    self.anchorPoint = CGPointMake(0, 0);
    self.physicsBody.dynamic = NO;
    self.name = @"Richter";
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.categoryBitMask = RichterCategory;
    self.physicsBody.contactTestBitMask = monsterCategory;
}

@end
