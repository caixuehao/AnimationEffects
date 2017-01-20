//
//  HaloViewController.m
//  AnimationEffects
//
//  Created by cxh on 17/1/20.
//  Copyright © 2017年 cxh. All rights reserved.
//

#import "HaloViewController.h"
#import "CALayer+Halo.h"
#import "Macro.h"
//http://code.cocoachina.com/view/134038
@interface HaloViewController ()

@end

@implementation HaloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorRGB(255, 255, 255);
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    [self.view addSubview:view];
    [view.layer applyHaloLayerWithRadius:8 color:ColorRGB(120, 244, 123)];//圆角
    
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 240, 100, 100)];
    [self.view addSubview:view2];
    [view2.layer applyHaloLayerWithWidth:8 color:ColorRGB(120, 244, 123)];//圆角
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
