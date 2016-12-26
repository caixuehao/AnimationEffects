//
//  QRCodeCreate.h
//  AnimationEffects
//
//  Created by C on 16/12/13.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeCreate : NSObject
+(instancetype)share;
-(UIImage*)QRCodeImageCreate:(NSString*)str;

-(UInt32 *)getColorArr:(UIImage*)image;

-(UInt8*)getQRCodeDataArr:(NSString*)str;

-(UIImage*)createImage:(UInt32*)colorArr width:(int)width height:(int)height scale:(int)scale;

@end
