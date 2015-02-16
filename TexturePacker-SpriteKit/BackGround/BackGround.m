//
//  Richter.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "BackGround.h"
#import "bgsprites.h"

@implementation BackGround

- (instancetype)initWithPosition:(CGPoint)position withBackgroungTexture:(SKTexture *)textureBg {

    if(self = [super initWithPosition:position withBackgroungTexture:textureBg]) {

        atlas = [SKTextureAtlas atlasNamed:BACKGROUND_ATLAS_NAME];
        self = [self initWithTexture:textureBg];
        [self addBackGroundPosition:position];
    }
    return self;
}

#pragma mark- Add monster

- (void)addBackGroundPosition:(CGPoint)posit {

    self.anchorPoint = CGPointMake(0, 0);
    self.position = posit;
}

@end
