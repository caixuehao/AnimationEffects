//
//  MeteorEntity.h
//  AnimationEffects
//
//  Created by C on 16/11/6.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeteorEntity : NSObject

@property(nonatomic,strong)UIColor* color;

@property(nonatomic)CGRect frame;

@property(nonatomic)float duration;

@property(nonatomic)CGAffineTransform transform;

@property(nonatomic)float moveDistance;

@end
