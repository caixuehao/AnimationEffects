//
//  CircleView.m
//  AnimationEffects
//
//  Created by C on 16/11/7.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "CircleView.h"
#import "UIView+Frame.h"
@implementation CircleView
//http://www.jianshu.com/p/02c341c748f9 CABasicAnimation
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    [path addArcWithCenter:CGPointMake(self.width/2,self.height/2-20) radius:self.height/2.0 startAngle:0 endAngle:M_PI clockwise:NO];
    CAShapeLayer* arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;//46,169,230
    arcLayer.fillColor=[UIColor colorWithRed:46.0/255.0 green:169.0/255.0 blue:230.0/255.0 alpha:0].CGColor;
    arcLayer.strokeColor=[UIColor colorWithWhite:1 alpha:0.7].CGColor;
    arcLayer.lineWidth=1;
    arcLayer.frame=self.frame;
    [self.layer addSublayer:arcLayer];
    
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=0.5;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [arcLayer addAnimation:bas forKey:@"key"];
    
    
    
    
    UIBezierPath *path2=[UIBezierPath bezierPath];
    [path2 addArcWithCenter:CGPointMake(self.width/2,self.height/2-20) radius:self.height/2.0 startAngle:0 endAngle:M_PI clockwise:YES];
    CAShapeLayer* arcLayer2=[CAShapeLayer layer];
    arcLayer2.path=path2.CGPath;//46,169,230
    arcLayer2.fillColor=[UIColor colorWithRed:46.0/255.0 green:169.0/255.0 blue:230.0/255.0 alpha:0].CGColor;
    arcLayer2.strokeColor=[UIColor colorWithWhite:1 alpha:0.7].CGColor;
    arcLayer2.lineWidth=1;
    arcLayer2.frame=self.frame;
    [self.layer addSublayer:arcLayer2];
    
    CABasicAnimation *bas2=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas2.duration=0.5;
    bas2.fromValue=[NSNumber numberWithInteger:0];
    bas2.toValue=[NSNumber numberWithInteger:1];
    [arcLayer2 addAnimation:bas2 forKey:@"key2"];

}
//动画开始时

//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

}
@end
