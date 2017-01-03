//
//  MainViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/1.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "MainViewController.h"

#import <Masonry.h>

#import "DanmakuViewController.h"
#import "StarrySkyViewController.h"
#import "JumpViewController.h"
#import "MagicMatrixViewController.h"
#import "Annular3DViewController.h"
#import "LuaTestViewController.h"
#import "QRCodeController.h"
#import "WhiteViewController.h"
#import "SocketTest.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* mainTableView;

@property(nonatomic,strong)NSArray<NSString*>* titlesArr;
@end

@implementation MainViewController{
    UIImageView* backgroundImage;
}
-(void)viewWillAppear:(BOOL)animated{
  [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titlesArr = @[@"弹幕",@"星空",@"视图跳跃",@"魔法阵",@"3D图片",@"LuaTest",@"二维码生成",@"白条(看起来有点像裸眼3D)",@"socket"];
    
    
    _mainTableView = ({
        UITableView *tableview = [[UITableView alloc] init];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.alpha = 0.7;
        [self.view addSubview:tableview];
        tableview;
    });
    
    backgroundImage = ({
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background1.jpg"]];
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        imageView;
    });
    
    
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[DanmakuViewController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[StarrySkyViewController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[JumpViewController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[MagicMatrixViewController alloc] init] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[[Annular3DViewController alloc] init] animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:[LuaTestViewController share] animated:YES];
            break;
        case 6:
            [self.navigationController pushViewController:[[QRCodeController alloc] init] animated:YES];
            break;
        case 7:
            [self.navigationController pushViewController:[[WhiteViewController alloc] init] animated:YES];
            break;
        case 8:
            [self.navigationController pushViewController:[[SocketTest alloc] init] animated:YES];
            break;
        default:
            [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
            break;
    }
    
}
#pragma mark -  UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titlesArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _titlesArr[indexPath.row];
    return cell;
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
