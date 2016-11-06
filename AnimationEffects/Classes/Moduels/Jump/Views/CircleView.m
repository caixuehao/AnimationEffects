//
//  CircleView.m
//  AnimationEffects
//
//  Created by C on 16/11/7.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRoundView:(CGPoint)centerPoint withStartAngle:(CGFloat)startAngle withEndAngle:(CGFloat)endAngle withRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:centerPoint radius:radius startAngle:startAngle endAngle:endAngle  clockwise:YES];
    
    CAShapeLayer* arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    //arcLayer.strokeColor可设置画笔颜色
    arcLayer.lineWidth = 10;
    arcLayer.frame = self.bounds;
    arcLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:arcLayer];
    
    //动画显示圆则调用
    [self drawLineAnimation:arcLayer];
}

- (void)drawLineAnimation:(CALayer*)layer {
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = 1;
    bas.delegate = self;
    bas.fromValue = [NSNumber numberWithInteger:0];
    bas.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}

@end
