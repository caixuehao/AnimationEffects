//
//  CALayer+Halo.h
//  HaloLayer
//
//  Created by LY on 2017/1/17.
//  Copyright © 2017年 LY. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "LYHaloLayer.h"

@interface CALayer (Halo)


/** 光晕层 圆角 */
- (void)applyHaloLayerWithRadius:(CGFloat)radius color:(UIColor *)color;
/** 光晕层 直角 */
- (void)applyHaloLayerWithWidth:(CGFloat)width color:(UIColor *)color;
/** 移除光晕层 */
- (void)removeHaloLayer;

@end
