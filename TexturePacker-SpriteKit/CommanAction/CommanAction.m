//
//  CommanObject.m
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 05/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "CommanAction.h"
#import "richter.h"

@implementation CommanAction

+ (SKAction *)jumpRichterActionWithScreenSize:(float)width {

        //Create the actions
    float velocity = 500.0/1.0;
    float realMoveDuration = width / velocity;

    SKAction *animate = [SKAction animateWithTextures:RICHRET_ANIM_CAPGUY_JUMP timePerFrame:realMoveDuration];
    SKAction *move = [SKAction moveByX:160 y:250 duration:1.0];

    SKAction *moveDown = [SKAction moveByX:160 y:-250 duration:2.0];
    SKAction *speed = [SKAction speedTo:realMoveDuration duration:0.0];
    SKAction *resetDirection = [SKAction scaleXTo:3 y:3 duration:0.0];
    SKAction *actionGroup = [SKAction group:@[resetDirection, animate, move,speed, moveDown]];

    return actionGroup;
}

+ (SKAction *)jumpRichterActionBackWithScreenSize:(float)width {

        //Create the actions
    float velocity = 500.0/1.0;
    float realMoveDuration = width/ velocity;

    SKAction *animate = [SKAction animateWithTextures:RICHRET_ANIM_CAPGUY_JUMP timePerFrame:realMoveDuration];
    SKAction *move = [SKAction moveByX:-160 y:250 duration:1.0];

    SKAction *moveDown = [SKAction moveByX:-160 y:-250 duration:2.0];
    SKAction *speed = [SKAction speedTo:realMoveDuration duration:0.0];
    SKAction *mirrorDirection = [SKAction scaleXTo:-3 y:3 duration:0.0];
    SKAction *actionGroup = [SKAction group:@[mirrorDirection, animate, move,speed, moveDown]];

    return actionGroup;
}

+ (SKAction *)walkCapGuyWithPoint:(CGPoint)location {

        //float velocity = 500.0/1.0;
        //float realMoveDuration = 1024/ velocity;

    SKAction *walk = [SKAction animateWithTextures:RICHRET_ANIM_CAPGUY_WALK timePerFrame:0.08];
    SKAction *walkAnim = [SKAction sequence:@[walk, walk]];
    SKAction *moveRight  = [SKAction moveTo:location duration:walkAnim.duration];
    SKAction *resetDirection   = [SKAction scaleXTo:3  y:3 duration:0.0];
    SKAction *walkAndMoveRight = [SKAction group:@[resetDirection,walkAnim, moveRight]];
        //[richterNode runAction:walkAndMoveRight];

    return walkAndMoveRight;
}

+ (SKAction *)walkCapGuyWithTruning:(CGPoint)location {
    
    SKAction *walk = [SKAction animateWithTextures:RICHRET_ANIM_CAPGUY_WALK timePerFrame:0.08];
    SKAction *walkAnim = [SKAction sequence:@[walk, walk]];
    SKAction *moveLeft = [SKAction moveTo:location duration:walkAnim.duration];
    SKAction *mirrorDirection = [SKAction scaleXTo:-3 y:3 duration:0.0];
    SKAction *walkAndMoveLeft = [SKAction group:@[mirrorDirection, walkAnim, moveLeft]];
        //   [richterNode runAction:walkAndMoveLeft];
    return walkAndMoveLeft;
}

+ (SKAction *)sitRicher:(CGPoint)location {

    SKAction *sit = [SKAction animateWithTextures:@[RICHTER_SIT_001] timePerFrame:0.08];
    SKAction *mirrorDirection = [SKAction scaleXTo:3 y:3 duration:0.0];
    SKAction *sitDown = [SKAction group:@[mirrorDirection, sit]];
    return sitDown;
}

+ (SKAction *)standUpRicher {

    SKAction *stand = [SKAction animateWithTextures:@[RICHTER_WALK_0001] timePerFrame:0.04];
    SKAction *mirrorDirection = [SKAction scaleXTo:3 y:3 duration:0.0];
    SKAction *standUp= [SKAction group:@[mirrorDirection, stand]];
    return standUp;
}


+ (BOOL)jumpRichterToStayOnPosition:(CGPoint)location forGivenLocation:(CGPoint)rectLocation {

    BOOL isLocationFound = false;
    CGRect stayRect1 = CGRectMake(rectLocation.x, rectLocation.y, 50, 40);
    BOOL contains = CGRectContainsPoint(stayRect1, location);

    if (contains == YES) {
        isLocationFound = YES;
    }
    return isLocationFound;
}

+ (SKAction *)jumpUPRichterWithLocation:(CGPoint)location withBack:(BOOL)isBackJump {

    SKAction *animate = [SKAction animateWithTextures:@[RICHER_JUMP_001] timePerFrame:0.05];
    SKAction *move = [SKAction moveTo:location duration:animate.duration];
        // SKAction *speed = [SKAction speedTo:250 duration:realMoveDuration];
    CGFloat scale;
    if (isBackJump == NO) {
        scale = 3;
    } else {
        scale = -3;
    }

    SKAction *mirrorDirection = [SKAction scaleXTo:scale y:3 duration:0.0];
    SKAction *actionStay = [SKAction animateWithTextures:@[RICHTER_WALK_0001] timePerFrame:0.6];
    SKAction *actionGroup = [SKAction group:@[mirrorDirection, animate, move, actionStay]];
    return actionGroup;
}

+ (SKAction *)jumpDownRichterWithLocation:(CGPoint)location withBack:(BOOL)isBackJump {

    SKAction *animate = [SKAction animateWithTextures:@[RICHER_JUMP_001] timePerFrame:0.05];
    SKAction *move = [SKAction moveTo:location duration:animate.duration];

    CGFloat scale;
    if (isBackJump == NO) {
        scale = 3;
    } else {
        scale = -3;
    }

    SKAction *mirrorDirection = [SKAction scaleXTo:scale y:3 duration:0.0];
    SKAction *actionStay = [SKAction animateWithTextures:@[RICHTER_WALK_0001] timePerFrame:0.6];
    SKAction *actionGroup = [SKAction group:@[mirrorDirection, animate, move, actionStay]];
    return actionGroup;
}

+ (int)addStarsAtXPositionAtRandomPlaceWithWidth:(CGFloat)width {

    int maxXCoord = width;
        //int nodeWidth = 68;

    int x = arc4random() % (maxXCoord);
    return x;
}

@end
