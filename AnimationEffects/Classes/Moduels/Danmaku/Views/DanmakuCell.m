//
//  DanmakuCell.m
//  AnimationEffects
//
//  Created by cxh on 16/11/2.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "DanmakuCell.h"
#import "Macro.h"
#import "UIView+Frame.h"

@implementation DanmakuCell{

}

-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}
-(void)dealloc{
//    NSLog(@"%s",__FUNCTION__);
}
-(void)setEntity:(DanmakuEntity *)entity{

//    self.font = (__bridge CFTypeRef _Nullable)(entity.font);
//    self.fontSize = entity.font.pointSize;
//    self.string = entity.text;
//    self.foregroundColor = entity.color.CGColor;
//    self.contentsScale = 1;
    _entity = entity;
    self.font = entity.font;
    self.textColor = entity.color;
    self.text = entity.text;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:entity.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    _cellSize = [entity.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    
    CABasicAnimation *animation;
    switch (entity.danmkuLabelStyle) {
        case DanmkuLabelStyleTop:
            self.frame = CGRectMake((SSize.width-_cellSize.width)*0.5, entity.positionY, _cellSize.width+20, _cellSize.height+5);
             animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
             animation.duration = 0.5;
             animation.beginTime = CACurrentMediaTime()+4;
             animation.toValue = 0;
            break;
        case DanmkuLabelStyleBottom:
            self.frame = CGRectMake((SSize.width-_cellSize.width)*0.5, entity.positionY, _cellSize.width+20, _cellSize.height+5);
            animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            animation.duration = 0.5;
            animation.beginTime = CACurrentMediaTime()+4;
            animation.toValue = 0;
            break;
        case DanmkuLabelStyleScrolled:
            self.frame = CGRectMake(SSize.width-0, entity.positionY, _cellSize.width+20, _cellSize.height+5);
            animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
            animation.duration = 5.0f;
            animation.fromValue = @(self.layer.position.x);
            animation.byValue = @(-(self.cellSize.width+SSize.width+20));
            break;
        default:
            break;
    }
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"animation"];
    
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)animtion finished:(BOOL)flag
{
    [self.layer removeAllAnimations];
    if(_disappearDelegate)[_disappearDelegate danmakuCellDisappear:self];
}


@end
