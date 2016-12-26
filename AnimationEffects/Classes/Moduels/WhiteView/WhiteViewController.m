//
//  WhiteViewController.m
//  AnimationEffects
//
//  Created by C on 16/12/24.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "WhiteViewController.h"
#import <Masonry.h>
#import "Macro.h"

@implementation WhiteViewController{
    UIView* starView;
}
-(void)viewDidLoad{
    
    [self loadSubviews];
    [self loadAnimation];
}

-(void)loadAnimation{
    [UIView animateWithDuration:3 animations:^{
        float width = 250;float height = 125;
        starView.frame = CGRectMake(SSize.width/2.0 - width/2.0, SSize.height*1.0/4.0 - height/2.0, width, height);
//        [starView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.view);
//            make.centerY.equalTo(self.view).multipliedBy(1/2.0);
//            make.size.mas_equalTo(CGSizeMake(250,125));
//        }];
//        [starView layoutIfNeeded];
    }];
    [self performSelector:@selector(viewOrder) withObject:nil afterDelay:2.0f];
}
-(void)viewOrder{
    [self.view addSubview:starView];
}

-(void)loadSubviews{
    UIImageView* backgroundImage = ({
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background1.jpg"]];
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        imageView;
    });
    
    starView = ({
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:view];
        view;
    });
    
    UIView* whiteView1 = ({
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        view;
    });
    
    UIView* whiteView2 = ({
        UIView* view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        view;
    });
    
    

    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    [whiteView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.width.equalTo(@10);
        make.centerX.equalTo(self.view).multipliedBy(2/3.0);
    }];
    
    [whiteView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.width.equalTo(@10);
        make.centerX.equalTo(self.view).multipliedBy(4/3.0);
    }];
    float width = 200;float height = 100;
    starView.frame = CGRectMake(SSize.width/2.0  - width/2.0, SSize.height*3.0/4.0 - height/2.0, width, height);
//    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view).multipliedBy(3/2.0);
//        make.size.mas_equalTo(CGSizeMake(200,100));
//    }];
}
@end
