//
//  CommanObject.h
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 05/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CommanAction : NSObject

+ (SKAction *)jumpRichterActionWithScreenSize:(float)width;
+ (SKAction *)jumpRichterActionBackWithScreenSize:(float)width;
+ (SKAction *)jumpUPRichterWithLocation:(CGPoint)location withBack:(BOOL)isBackJump;
+ (SKAction *)jumpDownRichterWithLocation:(CGPoint)location withBack:(BOOL)isBackJump;

+ (SKAction *)walkCapGuyWithPoint:(CGPoint)location;
+ (SKAction *)walkCapGuyWithTruning:(CGPoint)location;

+ (SKAction *)sitRicher:(CGPoint)location;

+ (BOOL)jumpRichterToStayOnPosition:(CGPoint)location forGivenLocation:(CGPoint)rectLocation;

+ (SKAction *)standUpRicher;
+ (int)addStarsAtXPositionAtRandomPlaceWithWidth:(CGFloat)width;

@end
