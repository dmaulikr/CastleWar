//
//  ScreenScene2.h
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ScrollingBackground.h"
#import "RichterNode.h"
#import "BackGround.h"
#import "Moon.h"
#import "SuperScene.h"

@interface ScreenScene2 : SuperScene {

    RichterNode *richterNode;
    BackGround *background;
    Moon *moon;

    ScrollingBackground *scrollVwBackground;

    CGPoint previousLocation;
    SKTextureAtlas *gameAtlasRichter;
    SKTextureAtlas *ritchterAtlas;
    SKTextureAtlas *zombieAtlas;

    BOOL isJumpUp;
}

@property(strong) SKTextureAtlas *atlas;


@end
