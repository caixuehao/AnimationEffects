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

-(void)setEntity:(DanmakuEntity *)entity{

//    self.font = (__bridge CFTypeRef _Nullable)(entity.font);
//    self.fontSize = entity.font.pointSize;
//    self.string = entity.text;
//    self.foregroundColor = entity.color.CGColor;
//    self.contentsScale = 1;

    self.font = entity.font;
    self.textColor = entity.color;
    self.text = entity.text;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:entity.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    _cellSize = [entity.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    switch (entity.danmkuLabelStyle) {
        case DanmkuLabelStyleTop:
            self.frame = CGRectMake((SSize.width-_cellSize.width)*0.5, entity.positionY, _cellSize.width+20, _cellSize.height+5);
             _animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
             _animation.duration = 0.5;
             _animation.beginTime = CACurrentMediaTime()+4;
             _animation.toValue = 0;
            break;
        case DanmkuLabelStyleBottom:
            self.frame = CGRectMake((SSize.width-_cellSize.width)*0.5, entity.positionY, _cellSize.width+20, _cellSize.height+5);
            _animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            _animation.duration = 0.5;
            _animation.beginTime = CACurrentMediaTime()+4;
             _animation.toValue = 0;
            break;
        case DanmkuLabelStyleScrolled:
            self.frame = CGRectMake(SSize.width-0, entity.positionY, _cellSize.width+20, _cellSize.height+5);
            _animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
            _animation.duration = 5.0f;
            _animation.fromValue = @(self.layer.position.x);
            _animation.byValue = @(-(self.cellSize.width+SSize.width+20));
            break;
        default:
            break;
    }
    _animation.delegate = self;
    [self.layer addAnimation:_animation forKey:@"animation"];
    
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)animtion finished:(BOOL)flag
{
    [_disappearDelegate danmakuCellDisappear:self];
}


@end
