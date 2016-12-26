//
//  QRCodeController.m
//  AnimationEffects
//
//  Created by C on 16/12/13.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "QRCodeController.h"
#import "QRCodeCreate.h"
#import <Masonry.h>

@implementation QRCodeController{
    UIImageView *QRCodeImageView;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    QRCodeImageView = ({
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor yellowColor];
       // imageView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:imageView];
        imageView;
    });

    [QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.equalTo(@230);
    }];

    NSLog(@"%lu,%lu",sizeof(UInt8),sizeof(UInt32));
   QRCodeImageView.image = [[QRCodeCreate share] QRCodeImageCreate:@"大傻逼！！"];
   UInt32* colorArr = [[QRCodeCreate share] getColorArr:QRCodeImageView.image];
   QRCodeImageView.image = [[QRCodeCreate share] createImage:colorArr width:27 height:27 scale:20];
   
}

@end
