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
#import "UIView+Frame.h"

#import "CircleView.h"

@implementation JumpViewController{
    
    UIImageView* backgroundImage;
    CAShapeLayer *arcLayer;
    
    NSMutableArray<UIView*>* subViews;
    
    NSTimer* timer;
    NSInteger currentTag;
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
    self.view.backgroundColor=[UIColor blueColor];
    
    subViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; ++i) {
        UIView* view = [[UIView alloc] initWithFrame:self.view.frame];
        view.tag = 100+i;
        view.backgroundColor = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
        [self.view addSubview:view];
        [subViews addObject:view];
    }
    currentTag = 103;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jumpView) userInfo:nil repeats:YES];
    CircleView* circleView = [[CircleView alloc] init];
    [self.view addSubview:circleView];
    circleView.frame = CGRectMake(50, 50, 100, 100);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}


-(void)jumpView{
    
    int ii = 0;
    NSInteger tag = 100;
    for(int i = 0 ; i < subViews.count;++i){
        //设置原始位置
        if (i+100!=currentTag) {
            switch (ii) {
                case 0:
                    subViews[i].frame = CGRectMake(0,-self.view.height , self.view.width, self.view.height);
                    break;
                case 1:
                    subViews[i].frame = CGRectMake(self.view.width,-self.view.height , self.view.width, self.view.height);
                    tag = i+100;
                    break;
                case 2:
                    subViews[i].frame = CGRectMake(self.view.width,0 , self.view.width, self.view.height);
                    break;
                default:
                    break;
            }
            ++ii;
        }
        //动画
        [UIView animateWithDuration:1.0 animations:^{
            subViews[i].origin = CGPointMake(subViews[i].origin.x+self.view.width, subViews[i].origin.y-self.view.height);
        }];
        currentTag = tag;
    }
}
@end
