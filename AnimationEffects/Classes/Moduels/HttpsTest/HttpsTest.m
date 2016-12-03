/*
 http://www.jianshu.com/p/4b5d2d47833d
 有时采用HTTPS 无法接受数据，是因为苹果将http使用的是TLS 1.2 SSL 加密请求数据，而服务器有的时候使用的还是TLS 1.1
 
 
 */

#import "HttpsTest.h"
#import "NSURLSession+HTTPS.h"
#define HTTPS_TEST_URL @"https://fate.dolosvr.com/ios/server_info.lua"
#define BAIDU_URL @"https://www.baidu.com"
static HttpsTest* httpsTestShare;

@interface HttpsTest()<NSURLSessionDelegate>
@property(nonatomic,weak)id test;
@end

@implementation HttpsTest
+(HttpsTest*)share{
    @synchronized(self){  //为了确保多线程情况下，仍然确保实体的唯一性
        if (!httpsTestShare) {
            httpsTestShare = [[self alloc] init];
        }
    }
    return httpsTestShare;
}
-(void)start{
    [self test1];
}
-(void)test1{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:HTTPS_TEST_URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString* str  = [[NSString alloc] initWithData:data encoding:4];
        NSLog(@"data:%@,error:%@",str,[error localizedDescription]);
        _test = response;
       // _test1 = response;
        [self performSelector:@selector(test3) withObject:nil afterDelay:0.2f];
    }] resume];
}
-(void)test2{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:[NSURL URLWithString:HTTPS_TEST_URL]] resume];
    
}

-(void)test3{
    NSLog(@"test:%@",_test);
}
#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    //AFNetworking中的处理方式
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    //判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        /*disposition：如何处理证书
         NSURLSessionAuthChallengePerformDefaultHandling:默认方式处理
         NSURLSessionAuthChallengeUseCredential：使用指定的证书    NSURLSessionAuthChallengeCancelAuthenticationChallenge：取消请求
         */
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
    NSLog(@"didReceiveResponse");
    completionHandler(NSURLSessionResponseAllow);
}
// 接收到服务器返回的数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    NSString* str  = [[NSString alloc] initWithData:data encoding:4];
    NSLog(@"data:%@",str);
}
// 请求完毕
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"didCompleteWithError:%@",[error localizedDescription]);
    
}
@end
