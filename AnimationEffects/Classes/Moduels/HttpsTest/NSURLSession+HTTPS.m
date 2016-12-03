//
//  NSURLSee.m
//  AnimationEffects
//
//  Created by C on 16/12/4.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "NSURLSession+HTTPS.h"

@implementation NSURLSession(HTTPS)
//-(void)dealloc{
//    NSLog(@"%s",__FUNCTION__);
//}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler{
    return [[[HTTPSRequest  alloc] init] dataTaskWithURL:url completionHandler:completionHandler];
}
@end



@interface HTTPSRequest()<NSURLSessionDelegate>
@property(nonatomic,strong) void (^completionHandler)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error);
@property(nonatomic,strong) NSMutableData* data;
@end




@implementation HTTPSRequest
//-(void)dealloc{
//   NSLog(@"%s",__FUNCTION__);
//}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler{
    _data = [[NSMutableData alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSLog(@"%@",@"NSURLSession+HTTPS");
    _completionHandler = completionHandler;
    return  [session dataTaskWithURL:url];
}


#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    //判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//         disposition：如何处理证书
//         NSURLSessionAuthChallengePerformDefaultHandling:默认方式处理
//         NSURLSessionAuthChallengeUseCredential：使用指定的证书
//         NSURLSessionAuthChallengeCancelAuthenticationChallenge：取消请求
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    //安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

// 接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

// 接收到服务器返回的数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

// 请求完毕
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [session invalidateAndCancel];
    if(_completionHandler)_completionHandler(_data,task.response,error);
  
}
@end

