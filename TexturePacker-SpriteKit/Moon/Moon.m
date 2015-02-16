//
//  Richter.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "Moon.h"
#import "bgsprites.h"

@implementation Moon

- (instancetype)initWithPosition:(CGPoint)position withBackgroungTexture:(SKTexture *)textureBg {

    if(self = [super initWithPosition:position withBackgroungTexture:nil]) {

        atlas = [SKTextureAtlas atlasNamed:BACKGROUND_ATLAS_NAME ];
        self = [self initWithTexture:SPRITES_TEX_MOON1];
        self.anchorPoint = CGPointMake(0.9, 0);
        [self runAction:[SKAction scaleXTo:1.3 y:3 duration:0.0]];
    }
    return self;
}

@end
