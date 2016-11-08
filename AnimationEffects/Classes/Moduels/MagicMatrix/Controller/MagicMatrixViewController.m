//
//  MagicMatrixViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/8.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "MagicMatrixViewController.h"
#import "MagicMatrixView.h"

#import "Macro.h"
@interface MagicMatrixViewController ()

@end

@implementation MagicMatrixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    // Do any additional setup after loading the view.
    MagicMatrixView* view = [[MagicMatrixView alloc] initWithFrame:CGRectMake(1, 50, SSize.width-3, SSize.width-3)];
    [self.view addSubview:view];
    [view performSelector:@selector(start) withObject:nil afterDelay:1.2f];
    
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
