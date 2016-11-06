//
//  JumpViewController.m
//  AnimationEffects
//
//  Created by C on 16/11/7.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "JumpViewController.h"

#import <Masonry.h>
#import "Macro.h"

#import "CircleView.h"

@implementation JumpViewController{
    
    UIImageView* backgroundImage;

}
-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    
    backgroundImage = ({
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background3.jpg"]];
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        imageView;
    });
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    CircleView* circleView = [[CircleView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [self.view addSubview:circleView];
    [circleView drawRoundView:circleView.center withStartAngle:0 withEndAngle:2*M_PI withRadius:50];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

@end
