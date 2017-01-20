//
//  SocketTest.m
//  AnimationEffects
//
//  Created by C on 16/12/25.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "SocketTest.h"
#include <sys/socket.h>
#include <netinet/in.h>//sockaddr_in
#include<arpa/inet.h>//inet_addr


#import <ifaddrs.h>
#import <arpa/inet.h>

#include <errno.h>  
#import <Masonry.h>
//http://blog.csdn.net/kesalin/article/details/8798039
//http://baike.baidu.com/link?url=1xiHZe7_pjnXoJ8CVr8VkKanC-mc2zdSJRBQQA9qPgXndnOX6F_Ao3BYlmSlt6NVkyDqaQCuyp0w_A7GusHOSK
#define MAX_LISTEN_NUM 100

@interface SocketTest()
//@property(nonatomic,assign)struct sockaddr_in servaddr;
@end


@implementation SocketTest{
    int socketFileDescriptor;
    //http://blog.csdn.net/samulelin/article/details/4431351
     struct sockaddr_in servaddr;
    int connectreturn;
}

-(void)dealloc{
    close(socketFileDescriptor);
}
-(void)viewDidLoad{
    [self loadSubViews];

   
   
}

-(void)createServerSocket{
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        [self createSocket];
    }];
}

-(void)createClientSocket{
     socketFileDescriptor = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    
//    int fcntlreturn = fcntl(socketFileDescriptor, F_GETFL,0);
//    fcntl(socketFileDescriptor, fcntlreturn|O_NONBLOCK);
    
    struct sockaddr_in socketParameters;
    socketParameters.sin_family = AF_INET;
    socketParameters.sin_port = htons(1995);
    socketParameters.sin_addr.s_addr = inet_addr("192.168.1.91");
    //http://blog.csdn.net/cj83111/article/details/5364138
    connectreturn = connect(socketFileDescriptor,(struct sockaddr *) &socketParameters, sizeof(socketParameters));
    NSLog(@"connectreturn:%d errno:%d str:%s len:%lu",connectreturn,errno,strerror(errno), sizeof(socketParameters));
    
    
//    for (int i = 0; i < 256; i++) {
//        for (int ii = 0; ii < 256; ii++) {
//            struct sockaddr_in socketParameters;
//            socketParameters.sin_family = AF_INET;
//            socketParameters.sin_port = htons(1995);
//            NSString* str = [NSString stringWithFormat:@"192.168.%d.%d",i,ii];
//            NSLog(@"%s",[str UTF8String]);
//            socketParameters.sin_addr.s_addr = inet_addr([str UTF8String]);
//            //http://blog.csdn.net/cj83111/article/details/5364138
//            connectreturn = connect(socketFileDescriptor,(struct sockaddr *) &socketParameters, sizeof(socketParameters));
//            NSLog(@"connectreturn:%d errno:%d str:%s len:%lu",connectreturn,errno,strerror(errno), sizeof(socketParameters));
//            if(connectreturn == 0){
//              
//                i = 256;break;
//            }
//        }
//    }
    
//    NSLog(@"%@",[self getIPAddress]);

}
-(void)sendClick{

    NSDictionary* dic = @{@"messageType":@1,@"messageSize":@99999999999};
    NSData* data =  [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    send(socketFileDescriptor, [data bytes], data.length, 0);
    NSLog(@"sendClick:%lu",data.length);
    close(socketFileDescriptor);
}
//192.168.1.91
//192.168.3.120

-(void)createSocket{
    /*
     服务器建立连接的流程和涉及到的函数：socket()、bind()、listen()、accept()、connect()、close()。
     
     结构体struct sockaddr_in ：网络通讯五元组，本端IP，本端端口、对端IP、对端端口、协议类型。
     */
    
    
   //初始化 socket
    socketFileDescriptor = socket(AF_INET, SOCK_STREAM, 0);
     //http://blog.csdn.net/nancy530421/article/details/6714974
    NSLog(@"socketFileDescriptor:%d",socketFileDescriptor);
    if (socketFileDescriptor == -1) return;
    NSLog(@"erron:%d str:%s",errno,strerror(errno));
    //绑定端口 bind
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(1989);//端口？
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);//INADDR_ANY表示任何IP
//    servaddr.sin_addr.s_addr= inet_addr([[self getIPAddress] UTF8String]);//将一个点分十进制的IP转换成一个长整数型数
//    struct ifaddrs *interfaces = NULL;
//    int success = getifaddrs(&interfaces);
//    if(success!=0){
//        NSLog(@"本机ip获取失败:%d",success);
//        return;
//    }
//    servaddr.sin_addr.s_addr = ((struct sockaddr_in *)interfaces->ifa_addr)->sin_addr.s_addr;
//    int bindreturn = bind(socketFileDescriptor, (struct sockaddr *)interfaces ,sizeof(&interfaces));
    int bindreturn = bind(socketFileDescriptor, (struct sockaddr *) &servaddr, sizeof(servaddr));
    NSLog(@"bindreturn:%d",bindreturn);
    if(bindreturn != 0)return;
    
    //监听 listen() listen函数在一般在调用bind之后-调用accept之前调用。
    int listenreturn = listen(socketFileDescriptor,MAX_LISTEN_NUM);
    NSLog(@"listenreturn:%d",listenreturn);
    if(listenreturn != 0)return;
    
    //accept() 等待并接受客户的连接 http://blog.csdn.net/acs713/article/details/9336605
//    http://ticktick.blog.51cto.com/823160/779866/

//    int other_socket = 0;
//    NSOperationQueue* acceptQueue = [[NSOperationQueue alloc] init];
//    [acceptQueue addOperationWithBlock:^{
//        while (true) {
            /* 参数：sockfd 监听套接字，即服务器端创建的用于listen的socket描述符。
             * 参数：addr  这是一个结果参数，它用来接受一个返回值，这返回值指定客户端的地址
             * 参数：len 描述 addr 的长度
             */
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        socklen_t len = sizeof(servaddr);
        char message[100] = "111111111111111111111111111111111111";
        int acceptreturn = accept(socketFileDescriptor, (struct sockaddr *) &servaddr, &len);
        NSLog(@"acceptreturn:%d",acceptreturn);
        if(acceptreturn < 0)return;
        
        while ( true)//接收并打印客户端数据
        {
            size_t recvreturn = recv(acceptreturn,message, 100, 0);
            if(recvreturn == acceptreturn)NSLog(@"recvreturn:%zu message:%s",recvreturn,message);
        }
    }];
}


//获取本机ip地址
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}



-(void)loadSubViews{
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton* clientBtn = ({
        UIButton* button = [[UIButton alloc] init];
        [button setTitle:@"ClientBtn" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(createClientSocket) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });

    UIButton* serverBtn = ({
        UIButton* button = [[UIButton alloc] init];
        [button setTitle:@"serverBtn" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(createServerSocket) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    UIButton* sendBtn = ({
        UIButton* button = [[UIButton alloc] init];
        [button setTitle:@"sendBtn" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    
    [clientBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(@100);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    
    [serverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(@150);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(@50);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

@end
