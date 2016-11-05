//
//  StarryEntity.m
//  AnimationEffects
//
//  Created by C on 16/11/5.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "StarryEntity.h"

@implementation StarryEntity
-(instancetype)init{
    if (self = [super init]) {
        _color = [UIColor colorWithRed:
                  (arc4random()%125+125)/255.0 green:(arc4random()%125+125)/255.0 blue:(arc4random()%125+125)/255.0 alpha:1];
        _duration = 10%arc4random()/5.0+1.0;
    }
    return self;
}
@end
