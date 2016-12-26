//
//  SocketTest.m
//  AnimationEffects
//
//  Created by C on 16/12/25.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "SocketTest.h"
#include <sys/socket.h>
#import <Masonry.h>
//http://blog.csdn.net/kesalin/article/details/8798039

@implementation SocketTest{
    int socketFileDescriptor;
    struct sockaddr_in *houstaddr;
}

-(void)dealloc{
    close(socketFileDescriptor);
}
-(void)viewDidLoad{
    [self loadSubViews];
    [self createSocket];
   
}

-(void)send{
    NSLog(@"ZZZZ");
}



-(void)createSocket{
   //初始化 socket
    socketFileDescriptor = socket(AF_UNSPEC, SOCK_STREAM, 0);
     //http://blog.csdn.net/nancy530421/article/details/6714974
    NSLog(@"socketFileDescriptor:%d",socketFileDescriptor);
    if (socketFileDescriptor == -1) return;
    //绑定端口 bind
//    houstaddr.sa_family = AF_UNSPEC;
//    houstaddr.sa_data = "123";
    bind(socketFileDescriptor, houstaddr, sizeof(houstaddr));
}



-(void)loadSubViews{
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton* button = [[UIButton alloc] init];
    [button setTitle:@"send" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

@end
