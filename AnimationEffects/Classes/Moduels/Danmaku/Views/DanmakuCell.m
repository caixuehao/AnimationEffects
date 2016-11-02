//
//  DanmakuCell.m
//  AnimationEffects
//
//  Created by cxh on 16/11/2.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "DanmakuCell.h"

@implementation DanmakuCell


-(void)setEntity:(DanmakuEntity *)entity{
    self.textColor = entity.color;
    self.text = entity.text;
    switch (entity.danmkuLabelStyle) {
        case DanmkuLabelStyleTop:
            
            break;
        case DanmkuLabelStyleBottom:
            break;
        case DanmkuLabelStyleScrolled:
            break;
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
