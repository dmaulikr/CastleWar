//
//  Richter.h
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#import "GameObject.h"

@interface BackGround : GameObject {

    SKTextureAtlas *atlas;
}

- (void)addBackGroundPosition:(CGPoint)posit;

@end
