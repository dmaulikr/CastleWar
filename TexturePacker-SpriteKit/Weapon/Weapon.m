//
//  Richter.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "Weapon.h"
#import "richter.h"

@implementation Weapon

- (instancetype)initWithPosition:(CGPoint)position withBackgroungTexture:(SKTexture *)textureBg {

    if(self = [super initWithPosition:position withBackgroungTexture:nil]) {

        atlas = [SKTextureAtlas atlasNamed:RICHTER_ATLAS_NAME];
        self = [self initWithTexture:textureBg];

        self.physicsBody =  [SKPhysicsBody bodyWithTexture:textureBg size:CGSizeMake(20, 20)];
        self.position = position;
        [self runAction:[SKAction scaleXTo:2.0 y:2.0 duration:0.0]];
        self.name = @"Weapon";
        self.zRotation = 0;
        self.physicsBody.categoryBitMask = weaponShipCategory;
        self.physicsBody.contactTestBitMask = monsterCategory;

        [self addFire];
    }
    return self;
}

- (void)addFire {

        // Emitter
    NSString *firePath = [[NSBundle mainBundle] pathForResource:@"FireOfWeapon" ofType:@"sks"];

    SKEmitterNode *star = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    star.position = CGPointMake(0, 0);
    star.name = @"Weapon";
    star.zPosition = 0;
    star.physicsBody = [SKPhysicsBody bodyWithTexture:nil size:CGSizeMake(20, 20)];
    self.physicsBody.categoryBitMask = weaponShipCategory;
    self.physicsBody.contactTestBitMask = monsterCategory;

    [self addChild:star];
}

@end
