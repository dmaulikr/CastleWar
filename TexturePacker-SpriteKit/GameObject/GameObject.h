//
//  GameObject.h
//  GoalingBall
//
//  Created by GrepRuby on 29/12/14.
//  Copyright (c) 2014 GrepRuby. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const uint32_t monsterCategory       =  0x1 << 0;
static const uint32_t RichterCategory       =  0x1 << 1;

static const uint32_t weaponShipCategory    =  0x1 << 2;
static const uint32_t starCategory          =  0x1 << 3;

@interface GameObject : SKSpriteNode

- (instancetype)initWithPosition:(CGPoint)position withBackgroungTexture:(SKTexture *)textureBg;

@end
