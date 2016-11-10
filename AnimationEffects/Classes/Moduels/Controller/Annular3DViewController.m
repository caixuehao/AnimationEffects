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
#import "UIView+Frame.h"


@interface Annular3DViewController ()

@end

@implementation Annular3DViewController{
    UIImageView* imageView22;
    MagicMatrixView* magicMatrixView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorRGB(213, 123, 231);
    
    
    
    UIView* Aview = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SSize.width, SSize.width)];
    
    float radius = Aview.width*0.5-1;
    UIBezierPath *circle1_1=[UIBezierPath bezierPath];
    [circle1_1 addArcWithCenter:CGPointMake(Aview.width*0.5, Aview.height*0.5)  radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer* circle1_1Layer=[CAShapeLayer layer];
    circle1_1Layer.path=circle1_1.CGPath;
    circle1_1Layer.strokeColor = ColorRGB(123, 0, 244).CGColor;
    circle1_1Layer.fillColor = ColorRGB(45, 54, 154).CGColor;
    circle1_1Layer.lineWidth=1;
    circle1_1Layer.frame=Aview.bounds;
    [Aview.layer addSublayer:circle1_1Layer];
    [self.view addSubview:Aview];
    
    for (int i = 0; i < 8; i++) {
        
        UIView* view = [[UIView alloc] init];
        view.bounds = CGRectMake(0, 0, 30, 100);
        view.backgroundColor = ColorRGB(231, 123, 213);
        view.center = CGPointMake(cos((M_PI*2)/8.0*i)*(radius-50)+Aview.width*0.5, sin((M_PI*2)/8.0*i)*(radius-50)+Aview.height*0.5);
        view.transform = CGAffineTransformMakeRotation((M_PI*2)/8.0*i);
        [Aview addSubview:view];
    }
}

-(void)loadSubViews{
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
    transform1 = CATransform3DRotate(transform1, M_PI_4*0.75, 1, 0, 0);
    magicMatrixView.layer.transform = transform1;
    [magicMatrixView setBackgroundColor:[UIColor whiteColor]];
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform1, -M_PI_2, 1, 0, 0);
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
