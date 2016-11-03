//
//  DanmakuCell.h
//  AnimationEffects
//
//  Created by cxh on 16/11/2.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DanmakuEntity.h"

@protocol DanmakuCellDisappearDelegate;

@interface DanmakuCell : UILabel//CATextLayer

@property(nonatomic,strong)DanmakuEntity* entity;

@property(nonatomic,readonly)CGSize cellSize;

@property(nonatomic,strong)CABasicAnimation *animation;

@property(nonatomic,weak)id<DanmakuCellDisappearDelegate>disappearDelegate;

@property(nonatomic,weak)DanmakuCell* previousCell;

@property(nonatomic,weak)DanmakuCell* nextCell;

@end
//数据刷新时调用
@protocol DanmakuCellDisappearDelegate
@optional//不一定要实现
-(void)danmakuCellDisappear:(DanmakuCell*)cell;
@end