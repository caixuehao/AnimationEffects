//
//  DanmakuViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/2.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "DanmakuViewController.h"

#import <Masonry.h>
#import "Macro.h"

#import "DanmakuCell.h"
#import "DanmakuEntity.h"
@interface DanmakuViewController ()<DanmakuCellDisappearDelegate>

@end

@implementation DanmakuViewController{
    //发现两个效率一样
    NSMutableArray<DanmakuCell *>* danmakuCellArr;
    NSMutableArray<DanmakuCell *>* discardedDanmakuCellArr;
    
    DanmakuCell *firstDanmakuCell;
    DanmakuCell *firstDiscardedDanmakuCell;

    
    float scrolledDanmakuPositionY;
    float topDanmakuPositionY;
    float bottomDanmakuPositionY;
    
    UIImageView* backgroundImage;
    
    NSTimer* timer;
}
-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
-(instancetype)init{
    if (self = [super init]) {
        danmakuCellArr = [[NSMutableArray alloc] init];
        discardedDanmakuCellArr = [[NSMutableArray alloc] init];
        
        scrolledDanmakuPositionY = 0;
        topDanmakuPositionY = 0;
        bottomDanmakuPositionY = SSize.height;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //强制横屏
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
    
    backgroundImage = ({
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background2.jpg"]];
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        imageView;
    });
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    //定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addDanmaku) userInfo:nil repeats:YES];
  
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    for(DanmakuCell* cell in discardedDanmakuCellArr){
        [cell removeFromSuperview];
    }
    for(DanmakuCell* cell in danmakuCellArr){
        [cell removeFromSuperview];
    }
    [discardedDanmakuCellArr removeAllObjects];
    [danmakuCellArr removeAllObjects];
}

//屏幕方向
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

-(void)addDanmaku{
    NSLog(@"%lu",danmakuCellArr.count);

    DanmakuCell* cell;
    //数组
    if (discardedDanmakuCellArr.count) {
        cell = [discardedDanmakuCellArr lastObject];
        [discardedDanmakuCellArr removeLastObject];
        [danmakuCellArr addObject:cell];
    }else{
        cell = [[DanmakuCell alloc] init];
        [danmakuCellArr addObject:cell];
        cell.disappearDelegate = self;
        [self.view addSubview:cell];
    }
    //链表
//    if(firstDiscardedDanmakuCell){
//        cell = firstDiscardedDanmakuCell;
//        firstDiscardedDanmakuCell = firstDiscardedDanmakuCell.nextCell;
//        
//        firstDanmakuCell.previousCell = cell;
//        firstDanmakuCell = cell.nextCell;
//    }else{
//        cell = [[DanmakuCell alloc] init];
//        cell.nextCell = firstDanmakuCell;
//        firstDanmakuCell = cell.nextCell;
//    cell.disappearDelegate = self;
//    [self.view addSubview:cell];
//    }
    
    
    

//    [self.view.layer addSublayer:cell];
    
    DanmakuEntity* entity = [[DanmakuEntity alloc] init];
    entity.font = [UIFont systemFontOfSize:arc4random()%15+10];
    entity.color = ColorRGB(arc4random()%255, arc4random()%255, arc4random()%255);
//    entity.danmkuLabelStyle = arc4random()%3;
    
    switch (entity.danmkuLabelStyle) {
        case DanmkuLabelStyleTop:
            entity.positionY = topDanmakuPositionY;
            break;
        case DanmkuLabelStyleScrolled:
            entity.positionY = scrolledDanmakuPositionY;
            break;
        case DanmkuLabelStyleBottom:
            entity.positionY =  bottomDanmakuPositionY;
            break;
        default:
            break;
    }
    
    cell.entity = entity;

    switch (entity.danmkuLabelStyle) {
        case DanmkuLabelStyleTop:
            topDanmakuPositionY += cell.cellSize.height;
            topDanmakuPositionY = topDanmakuPositionY<SSize.height-100?topDanmakuPositionY:0;
            break;
        case DanmkuLabelStyleScrolled:
            scrolledDanmakuPositionY += cell.cellSize.height;
            scrolledDanmakuPositionY = scrolledDanmakuPositionY<SSize.height-0?scrolledDanmakuPositionY:0;
            break;
        case DanmkuLabelStyleBottom:
            bottomDanmakuPositionY -= cell.cellSize.height;
            bottomDanmakuPositionY = bottomDanmakuPositionY>100?bottomDanmakuPositionY:SSize.height;
            break;
        default:
            break;
    }
}

#pragma mark - DanmakuCellDisappearDelegate
-(void)danmakuCellDisappear:(DanmakuCell *)cell{
     //链表
//    cell.previousCell.nextCell = cell.nextCell;
//    cell.nextCell = firstDiscardedDanmakuCell;
//    firstDiscardedDanmakuCell = cell;

    //数组
    [danmakuCellArr removeObject:cell];
    [discardedDanmakuCellArr addObject:cell];
 
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
