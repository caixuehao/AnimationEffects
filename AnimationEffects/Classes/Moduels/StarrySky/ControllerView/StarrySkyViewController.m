//
//  StarrySkyViewController.m
//  AnimationEffects
//
//  Created by C on 16/11/3.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "StarrySkyViewController.h"

#import <Masonry.h>
#import "Macro.h"
#import "StarryView.h"


@interface StarrySkyViewController()<StarryViewDisappearDelegate>

@end

@implementation StarrySkyViewController{
    UIImageView* backgroundImage;
    CAEmitterLayer *starryEmitterLayer;
    NSTimer* timer;
    
    
    NSMutableArray<StarryView *>* starryViewArr;
    NSMutableArray<StarryView *>* discardedStarryViewArr;
}
-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
-(instancetype)init{
    if (self = [super init]) {
        starryViewArr = [[NSMutableArray alloc] init];
        discardedStarryViewArr = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    
    backgroundImage = ({
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background1.jpg"]];
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        imageView;
    });
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];

//    [self loadEmitterLayer];//用粒子效果实现的，无法实现闪缩效果（应该是我不会玩），，，
    
    //定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(addStarryViews) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (StarryView* view in starryViewArr) {
        [view removeFromSuperview];
    }
    for (StarryView* view in discardedStarryViewArr) {
        [view removeFromSuperview];
    }
    [starryViewArr removeAllObjects];
    [discardedStarryViewArr removeAllObjects];
    [timer invalidate];
}
//屏幕方向
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

//loadCAEmitterLayer

-(void)loadEmitterLayer{
    starryEmitterLayer = ({
        //设置发射器
        CAEmitterLayer* emitter =  [[CAEmitterLayer alloc] init];
        emitter.emitterPosition = self.view.center;//中心点
        emitter.emitterSize = CGSizeMake(SSize.width, SSize.height/3.0);//大小
        emitter.emitterShape = kCAEmitterLayerRectangle;//发射器的形状
        emitter.emitterMode = kCAEmitterLayerVolume;//发射模式
        emitter.renderMode = kCAEmitterLayerUnordered;//渲染模式
        emitter.preservesDepth = YES;//三维空间效果
        //发射单元
        CAEmitterCell* cell = [CAEmitterCell emitterCell];
        cell.birthRate = 10;
        cell.contents=(id)[[UIImage imageNamed:@"starry"]CGImage];
        
        cell.lifetime = 6.0;
        cell.lifetimeRange = 1.5;
        
        cell.color = [UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1].CGColor;
        cell.redRange = 0.4;
        cell.greenRange = 0.4;
        cell.blueRange = 0;
        
        cell.scale = 0.1;
        cell.scaleRange = 0.5;
        
        cell.emissionLongitude=M_PI+M_PI_2;
        cell.emissionRange=M_PI_2;
        
        cell.alphaSpeed = -1;
        
        cell.contentsRect = CGRectMake(0, 0, 10, 10);
        [cell setName:@"cell"];
        
        
        //烟雾
//        CAEmitterCell * smoke = [CAEmitterCell emitterCell];
//        smoke.birthRate=400;
//        smoke.lifetime=3.0;
//        smoke.lifetimeRange=1.5;
//        smoke.color=[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.05]CGColor];
//        smoke.contents=(id)[[UIImage imageNamed:@"starry.png"]CGImage];
//        [smoke setName:@"smoke"];
//        
//        smoke.velocity=250;
//        smoke.velocityRange=100;
//        smoke.emissionLongitude=M_PI+M_PI_2;
//        smoke.emissionRange=M_PI_2;
        
        emitter.emitterCells = @[cell];
        [self.view.layer addSublayer:emitter];
        emitter;
    });
    
}


-(void)addStarryViews{
    int hight = SSize.height;
    int width = SSize.width;
    int length = arc4random()%4+4;
    
    StarryView* starryView;
    if (discardedStarryViewArr.count) {
        starryView = [discardedStarryViewArr lastObject];
        [discardedStarryViewArr removeLastObject];
    }else{
        starryView = [[StarryView alloc] init];
         starryView.disappearDelegate = self;
        [self.view addSubview:starryView];
    }

    StarryEntity* entity = [[StarryEntity alloc] init];
    entity.frame = CGRectMake(0+arc4random()%width, SSize.height/3.0+arc4random()%hight/3, length,length);
    starryView.entity = entity;
    
    
    [starryViewArr addObject:starryView];
//    NSLog(@"%lu",starryViewArr.count);
}

#pragma mark - StarryViewDisappearDelegate
-(void)starryViewDisappear:(StarryView *)starryView{
    [starryViewArr removeObject:starryView];
    [discardedStarryViewArr addObject:starryView];
}
@end
