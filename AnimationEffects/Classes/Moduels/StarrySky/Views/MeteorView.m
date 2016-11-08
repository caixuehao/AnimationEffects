//
//  MeteorView.m
//  AnimationEffects
//
//  Created by C on 16/11/6.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "MeteorView.h"

@implementation MeteorView

-(void)dealloc{
//        NSLog(@"%s",__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        UIImage* image = [UIImage imageNamed:@"meteor.png"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.image = image;
    }
    return self;
}

-(void)setEntity:(MeteorEntity *)entity{
    self.frame = entity.frame;
    
    self.tintColor = entity.color;
    
//    self.transform = entity.transform;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = entity.duration/2.0;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.fromValue = @(0);
    animation.toValue = @(1.0);
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"animation"];
    
    
    CABasicAnimation* animation2 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation2.duration = entity.duration;
    animation2.autoreverses = NO;
//    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation2.byValue =  @(-entity.moveDistance);
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation2 forKey:@"animation2"];
    
    
    CABasicAnimation* animation3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation3.duration = entity.duration;
    animation3.autoreverses = NO;
//    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation3.byValue =  @(entity.moveDistance);
    animation3.removedOnCompletion = NO;
    animation3.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation3 forKey:@"animation3"];
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)animtion finished:(BOOL)flag
{
    self.alpha = 0;;
    [self.layer removeAllAnimations];
    if(_disappearDelegate)[_disappearDelegate meteorViewDisappear:self];
}

@end
