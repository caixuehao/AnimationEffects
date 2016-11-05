//
//  DanmakuEntity.m
//  AnimationEffects
//
//  Created by cxh on 16/11/2.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "DanmakuEntity.h"
#import "Macro.h"

@implementation DanmakuEntity

-(instancetype)init{
    if (self = [super init]) {
        _danmakuLabelStatus = DanmakuLabelStatusRuning;
        _danmkuLabelStyle = DanmkuLabelStyleScrolled;
        _text = @"~~~~~";
        _font = [UIFont systemFontOfSize:15];
        _color = ColorWhite(255);
    }
    return self;
}
@end
