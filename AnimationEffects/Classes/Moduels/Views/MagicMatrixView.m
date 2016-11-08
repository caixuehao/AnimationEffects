//
//  MagicMatrixView.m
//  AnimationEffects
//
//  Created by cxh on 16/11/8.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "MagicMatrixView.h"
#import "UIView+Frame.h"
#import "Macro.h"

@implementation MagicMatrixView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)start{
    float height = self.height;
    float width = self.width;
    
    float radius1 = width*0.5;
    float radius2 = width*0.45;
    
    CGPoint center = CGPointMake(width*0.5, height*0.5);
    
    
    
    //先画两个外圈
    UIBezierPath *circle1_1=[UIBezierPath bezierPath];
    [circle1_1 addArcWithCenter:center radius:radius1 startAngle:0 endAngle:M_PI clockwise:NO];
    
    CAShapeLayer* circle1_1Layer=[CAShapeLayer layer];
    circle1_1Layer.path=circle1_1.CGPath;
    circle1_1Layer.strokeColor = ColorRGB(123, 0, 244).CGColor;
    circle1_1Layer.lineWidth=1;
    circle1_1Layer.frame=self.frame;
    [self.layer addSublayer:circle1_1Layer];
    
    CABasicAnimation *circle1_1bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circle1_1bas.duration=2;
    circle1_1bas.delegate=self;
    circle1_1bas.fromValue=[NSNumber numberWithInteger:0];
    circle1_1bas.toValue=[NSNumber numberWithInteger:1];
    [circle1_1Layer addAnimation:circle1_1bas forKey:@"circle1_1"];

    
    UIBezierPath *circle1_2=[UIBezierPath bezierPath];
    [circle1_2 addArcWithCenter:center radius:radius1 startAngle:0 endAngle:M_PI clockwise:YES];
    CAShapeLayer* circle1_2Layer=[CAShapeLayer layer];
    circle1_2Layer.path=circle1_2.CGPath;
    circle1_2Layer.strokeColor = ColorRGB(123, 0, 244).CGColor;
    circle1_2Layer.fillColor = [UIColor clearColor].CGColor;
    circle1_2Layer.lineWidth=1;
    circle1_2Layer.frame=self.frame;
    [self.layer addSublayer:circle1_2Layer];
    
    CABasicAnimation *circle1_2bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circle1_2bas.duration=2;
    circle1_2bas.delegate=self;
    circle1_2bas.fromValue=[NSNumber numberWithInteger:0];
    circle1_2bas.toValue=[NSNumber numberWithInteger:1];
    [circle1_2Layer addAnimation:circle1_2bas forKey:@"circle1_2"];
    

    UIBezierPath *circle2_1=[UIBezierPath bezierPath];
    [circle2_1 addArcWithCenter:center radius:radius2 startAngle:0 endAngle:M_PI clockwise:NO];
    
    CAShapeLayer* circle2_1Layer=[CAShapeLayer layer];
    circle2_1Layer.path=circle2_1.CGPath;
    circle2_1Layer.strokeColor = ColorRGB(123, 0, 244).CGColor;
    circle2_1Layer.lineWidth=1;
    circle2_1Layer.frame=self.frame;
    [self.layer addSublayer:circle2_1Layer];
    
    CABasicAnimation *circle2_1bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circle2_1bas.duration=2;
    circle2_1bas.delegate=self;
    circle2_1bas.fromValue=[NSNumber numberWithInteger:0];
    circle2_1bas.toValue=[NSNumber numberWithInteger:1];
    [circle2_1Layer addAnimation:circle2_1bas forKey:@"circle2_1"];
    
    
    UIBezierPath *circle2_2=[UIBezierPath bezierPath];
    [circle2_2 addArcWithCenter:center radius:radius2 startAngle:0 endAngle:M_PI clockwise:YES];
    CAShapeLayer* circle2_2Layer=[CAShapeLayer layer];
    circle2_2Layer.path=circle2_2.CGPath;
    circle2_2Layer.strokeColor = ColorRGB(123, 0, 244).CGColor;
    circle2_2Layer.fillColor = [UIColor clearColor].CGColor;
    circle2_2Layer.lineWidth=1;
    circle2_2Layer.frame=self.frame;
    [self.layer addSublayer:circle2_2Layer];
    
    CABasicAnimation *circle2_2bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circle2_2bas.duration=2;
    circle2_2bas.delegate=self;
    circle2_2bas.fromValue=[NSNumber numberWithInteger:0];
    circle2_2bas.toValue=[NSNumber numberWithInteger:1];
    [circle2_2Layer addAnimation:circle2_2bas forKey:@"circle1_2"];
    
    //再画两个等边三角形
    UIBezierPath* triangle1Path = [UIBezierPath bezierPath];
    CGPoint trianglePoint1_1 = CGPointMake(center.x, center.y+radius2);
    CGPoint trianglePoint1_2 = CGPointMake(center.x+radius2*0.5*sqrt(3), center.y-radius2*0.5);
    CGPoint trianglePoint1_3 = CGPointMake(center.x-radius2*0.5*sqrt(3), center.y-radius2*0.5);
    [triangle1Path moveToPoint:trianglePoint1_1];
    [triangle1Path addLineToPoint:trianglePoint1_2];
    [triangle1Path addLineToPoint:trianglePoint1_3];
    [triangle1Path closePath];
    
    CAShapeLayer* triangle1Layer=[CAShapeLayer layer];
    triangle1Layer.path=triangle1Path.CGPath;
    triangle1Layer.strokeColor = ColorRGB(123, 0, 244).CGColor;
    triangle1Layer.fillColor = [UIColor clearColor].CGColor;
    triangle1Layer.lineWidth=1;
    triangle1Layer.frame=self.frame;
    [self.layer addSublayer:triangle1Layer];
    
    CABasicAnimation *triangle1bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    triangle1bas.duration=2;
    triangle1bas.delegate=self;
    triangle1bas.fromValue=[NSNumber numberWithInteger:0];
    triangle1bas.toValue=[NSNumber numberWithInteger:1];
    [triangle1Layer addAnimation:triangle1bas forKey:@"triangle1"];
    
    UIBezierPath* triangle2Path = [UIBezierPath bezierPath];
    CGPoint trianglePoint2_1 = CGPointMake(center.x, center.y-radius2);
    CGPoint trianglePoint2_2 = CGPointMake(center.x+radius2*0.5*sqrt(3), center.y+radius2*0.5);
    CGPoint trianglePoint2_3 = CGPointMake(center.x-radius2*0.5*sqrt(3), center.y+radius2*0.5);
    [triangle2Path moveToPoint:trianglePoint2_1];
    [triangle2Path addLineToPoint:trianglePoint2_2];
    [triangle2Path addLineToPoint:trianglePoint2_3];
    [triangle2Path closePath];

    
    CAShapeLayer* triangle2Layer=[CAShapeLayer layer];
    triangle2Layer.path=triangle2Path.CGPath;
    triangle2Layer.strokeColor = ColorRGB(123, 0, 244).CGColor;
    triangle2Layer.lineWidth=1;
    triangle2Layer.fillColor = [UIColor clearColor].CGColor;
    triangle2Layer.frame=self.frame;
    [self.layer addSublayer:triangle2Layer];
    
    CABasicAnimation *triangle2bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    triangle2bas.duration=2;
    triangle2bas.delegate=self;
    triangle2bas.fromValue=[NSNumber numberWithInteger:0];
    triangle2bas.toValue=[NSNumber numberWithInteger:1];
    [triangle2Layer addAnimation:triangle2bas forKey:@"triangle1"];
    
    //写个字？
    CATextLayer*  textLayer = [[CATextLayer alloc] init];
//    textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:20]);
    textLayer.string = @"。。。。。。。。。。。。。。。";
    textLayer.alignmentMode = kCAAlignmentLeft;
    textLayer.fontSize = width*0.2;
    textLayer.wrapped = YES;
    textLayer.foregroundColor = ColorRGB(255, 20, 49).CGColor;
    textLayer.contentsScale = 1;
    textLayer.position = center;
    textLayer.frame = CGRectMake(center.x-width*0.1, center.y-width*0.1, width*0.2, width*0.2);
    [self.layer addSublayer:textLayer];
    
    CABasicAnimation *textbas=[CABasicAnimation animationWithKeyPath:@"string"];
    textbas.duration=2;
    textbas.delegate=self;
    textbas.fromValue=[NSNumber numberWithInteger:0];
    textbas.toValue=[NSNumber numberWithInteger:1];
    [textLayer addAnimation:textbas forKey:@"triangle1"];
}


//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}
@end
