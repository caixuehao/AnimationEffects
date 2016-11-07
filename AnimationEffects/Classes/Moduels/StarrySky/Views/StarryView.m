//
//  StarryView.m
//  AnimationEffects
//
//  Created by C on 16/11/5.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "StarryView.h"

@implementation StarryView
-(void)dealloc{
//    NSLog(@"%s",__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        UIImage* image = [UIImage imageNamed:@"starry.png"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.image = image;
    }
    return self;
}
-(void)setEntity:(StarryEntity *)entity{
    self.frame = entity.frame;
    
    self.tintColor = entity.color;
    
//    self.transform = CGAffineTransformMakeRotation((arc4random()%314)/100.0);
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = entity.duration;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.fromValue = @(0);
    animation.byValue = @(1.0);
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"animation"];
}
//动画结束时
- (void)animationDidStop:(CAAnimation *)animtion finished:(BOOL)flag
{
    self.alpha = 0;;
    [self.layer removeAllAnimations];
    if(_disappearDelegate)[_disappearDelegate starryViewDisappear:self];
}


@end
