//
//  GRModelOfLifeScoreAndDemo.hscore
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 08/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GRNodeLife.h"
#import "GRNodeScore.h"
#import "MyScene.h"

@protocol GRModelOfLifeScoreDlegate;

@interface GRModelOfLifeScore : NSObject {
    
}

@property (unsafe_unretained)id <GRModelOfLifeScoreDlegate>grModelOfLifeScoreDlegate;

#pragma mark - Function

+ (id)initWithSize:(CGSize)size;
+ (void)updateScoreOfNodeWithScoreOfStar;
+ (void)updateScoreOfNodeWithScoreOfLife;
+ (void)updateScoreOfNodeWithScoreToKillMonster;
+ (void)removeNode:(id)sceneName;
+ (GRNodeLife *)addNodeLife;

@end

@protocol GRModelOfLifeScoreDlegate <NSObject>


@end
