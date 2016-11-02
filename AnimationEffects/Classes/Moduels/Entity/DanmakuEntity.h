//
//  DanmakuEntity.h
//  AnimationEffects
//
//  Created by cxh on 16/11/2.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DanmakuLabelStatus) {
    DanmakuLabelStatusEnded,
    DanmakuLabelStatusRuning,
    DanmakuLabelStatusPaused,
};

typedef NS_ENUM(NSInteger, DanmkuLabelStyle) {
    DanmkuLabelStyleScrolled,
    DanmkuLabelStyleTop,
    DanmkuLabelStyleBottom
};

@interface DanmakuEntity : NSObject

@property(nonatomic)DanmakuLabelStatus danmakuLabelStatus;

@property(nonatomic)DanmkuLabelStyle danmkuLabelStyle;

@property(nonatomic,strong)NSString* text;

@property(nonatomic)float fontSize;

@property(nonatomic,strong)UIColor* color;

@end
