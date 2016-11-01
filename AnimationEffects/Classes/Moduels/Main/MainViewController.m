//
//  MainViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/1.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "MainViewController.h"
#import <Masonry.h>

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* mainTableView;

@property(nonatomic,strong)NSArray<NSDictionary*>* viewControllerArr;
@end

@implementation MainViewController{
    UIImageView* backgroundImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewControllerArr = @[@{@"vc":[[UIViewController alloc] init],@"title":@"test1"},
                           @{@"vc":[[UIViewController alloc] init],@"title":@"test2"},
                           @{@"vc":[[UIViewController alloc] init],@"title":@"test3"},
                           @{@"vc":[[UIViewController alloc] init],@"title":@"test4"}];
    
    
    _mainTableView = ({
        UITableView *tableview = [[UITableView alloc] init];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.alpha = 0.7;
        [self.view addSubview:tableview];
        tableview;
    });
    
    backgroundImage = ({
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
        [self.view addSubview:imageView];
        [self.view sendSubviewToBack:imageView];
        imageView;
    });
    
    
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:_viewControllerArr[indexPath.row][@"vc"] animated:YES];
}
#pragma mark -  UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _viewControllerArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _viewControllerArr[indexPath.row][@"title"];
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
