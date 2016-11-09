//
//  Annular3DViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/9.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "Annular3DViewController.h"
#import "Macro.h"

@interface Annular3DViewController ()

@end

@implementation Annular3DViewController{
    UIImageView* imageView22;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorRGB(213, 123, 231);
    imageView22 = [[UIImageView alloc] init];
    imageView22.center = self.view.center;
    imageView22.bounds = CGRectMake(0, 0, 140, 360);
    imageView22.image = [UIImage imageNamed:@"22"];
    imageView22.backgroundColor =ColorRGB(123, 213, 231);
    [self.view addSubview:imageView22];
    
    //create a new transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 0, 0);
    imageView22.layer.transform = transform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
    
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
