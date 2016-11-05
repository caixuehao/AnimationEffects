//
//  StarryView.h
//  AnimationEffects
//
//  Created by C on 16/11/5.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarryEntity.h"


@protocol StarryViewDisappearDelegate;

@interface StarryView : UIImageView

@property(nonatomic,strong)StarryEntity* entity;

@property(nonatomic,weak)id<StarryViewDisappearDelegate> disappearDelegate;

@end

@protocol StarryViewDisappearDelegate
@optional//不一定要实现
-(void)starryViewDisappear:(StarryView*)starryView;
@end