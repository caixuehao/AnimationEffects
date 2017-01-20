//
//  TLayer.h
//  TestProject
//
//  Created by LY on 2017/1/16.
//  Copyright © 2017年 LY. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface LYHaloLayer : CALayer

// 直角
+ (LYHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color width:(CGFloat)width;
+ (LYHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color width:(CGFloat)width outward:(BOOL)outward;

// 圆角
+ (LYHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius;
+ (LYHaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius outward:(BOOL)outward;


@end




