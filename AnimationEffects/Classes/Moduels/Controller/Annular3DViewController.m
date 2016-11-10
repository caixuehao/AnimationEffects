//
//  Annular3DViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/9.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "Annular3DViewController.h"
#import "Macro.h"
#import "MagicMatrixView.h"



@interface Annular3DViewController ()

@end

@implementation Annular3DViewController{
    UIImageView* imageView22;
    MagicMatrixView* magicMatrixView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorRGB(213, 123, 231);
    
    magicMatrixView = [[MagicMatrixView alloc] init];
    magicMatrixView.frame = CGRectMake(0, 50, SSize.width, SSize.width);
    [self.view addSubview:magicMatrixView];
//    [magicMatrixView start];
    
   
    imageView22 = [[UIImageView alloc] init];
    imageView22.frame = CGRectMake(SSize.width*0.5-35, SSize.width-90, 70, 180);
    imageView22.image = [UIImage imageNamed:@"22"];
    imageView22.backgroundColor =ColorRGB(123, 213, 231);
    [magicMatrixView addSubview:imageView22];
    

    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = -1.0/500.0;
    transform1 = CATransform3DRotate(transform1, M_PI_4, 1, 0, 0);
    magicMatrixView.layer.transform = transform1;
    [magicMatrixView setBackgroundColor:[UIColor whiteColor]];
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, -M_PI_4, 1, 0, 0);
    imageView22.layer.shouldRasterize = YES ;
    imageView22.layer.anchorPoint = CGPointMake(0.5, 1);
//    imageView22.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    imageView22.layer.transform = transform;
    //create a new transform

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
