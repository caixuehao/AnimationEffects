//
//  MeteorView.h
//  AnimationEffects
//
//  Created by C on 16/11/6.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeteorEntity.h"
@protocol MeteorViewDisappearDelegate;

@interface MeteorView : UIImageView

@property(nonatomic,strong)MeteorEntity* entity;

@property(nonatomic,weak)id<MeteorViewDisappearDelegate> disappearDelegate;

@end

@protocol MeteorViewDisappearDelegate
@optional//不一定要实现
-(void)meteorViewDisappear:(MeteorView*)meteorView;
@end