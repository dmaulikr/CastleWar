//
//  richter.h
//  TexturePacker-SpriteKit
//
//  Created by GrepRuby on 02/01/15.
//  Copyright (c) 2015 CodeAndWeb. All rights reserved.
//

#ifndef _RICHTER_ATLAS_
#define _RICHTER_ATLAS_


#define RICHTER_ATLAS_NAME @"richter"

#define RICHTER__SPR       @"richter1@2x.png"

#define SPRITES_TEX_RICHRET1       [SKTexture textureWithImageNamed:@"richter1@2x.png"]

#define RICHTER_WALK_0001 [SKTexture textureWithImageNamed:@"richter_walk1.png"]
#define RICHTER_0002 [SKTexture textureWithImageNamed:@"richter2.png"]
#define RICHTER_0003 [SKTexture textureWithImageNamed:@"richter3.png"]
#define RICHTER_SIT_001 [SKTexture textureWithImageNamed:@"sit1.png"]
#define RICHTER_SIT_002 [SKTexture textureWithImageNamed:@"sit2.png"]
#define WEAPON_001 [SKTexture textureWithImageNamed:@"weapon1.png"]
#define RICHER_JUMP_001 [SKTexture textureWithImageNamed:@"richter_jump7.png"]

#define RICHRET_ANIM_CAPGUY_WALK @[ \
[SKTexture textureWithImageNamed:@"richter_walk1.png"], \
[SKTexture textureWithImageNamed:@"richter_walk2.png"], \
[SKTexture textureWithImageNamed:@"richter_walk3.png"], \
[SKTexture textureWithImageNamed:@"richter_walk4.png"], \
[SKTexture textureWithImageNamed:@"richter_walk5.png"], \
[SKTexture textureWithImageNamed:@"richter_walk6.png"], \
[SKTexture textureWithImageNamed:@"richter_walk7.png"], \
[SKTexture textureWithImageNamed:@"richter_walk8.png"], \
]

#define RICHRET_ANIM_CAPGUY_JUMP @[ \
[SKTexture textureWithImageNamed:@"richter_jump6.png"], \
[SKTexture textureWithImageNamed:@"richter_walk1.png"],\
]


/*
 [SKTexture textureWithImageNamed:@"richter_jump1.png"], \
 [SKTexture textureWithImageNamed:@"richter_jump2.png"], \
 [SKTexture textureWithImageNamed:@"richter_jump3.png"], \
 [SKTexture textureWithImageNamed:@"richter_jump4.png"], \
 [SKTexture textureWithImageNamed:@"richter_jump5.png"], \
 [SKTexture textureWithImageNamed:@"richter_jump8.png"], \

 */

#define RICHRET_ANIM_CAPGUY_JUMPDOWN @[ \
[SKTexture textureWithImageNamed:@"richter_jumpdown1.png"], \
[SKTexture textureWithImageNamed:@"richter_jumpdown2.png"], \
]

#define RICHRET_ANIM_CAPGUY_JUMPHIT @[ \
[SKTexture textureWithImageNamed:@"richter_jumphit1.png"], \
[SKTexture textureWithImageNamed:@"richter_jumphit2.png"], \
]

#endif