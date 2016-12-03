//
//  NSURLSee.h
//  AnimationEffects
//
//  Created by C on 16/12/4.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HTTPSRequest;

@interface NSURLSession(HTTPS)
//- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler
- (NSURLSessionDataTask * __nullable)dataTaskWithURL:(NSURL * __nullable)url completionHandler:(void (^__nullable)(NSData * __nullable data, NSURLResponse * __nullable response, NSError *__nullable error))completionHandler;

@end

@interface HTTPSRequest : NSObject
- (NSURLSessionDataTask * __nullable)dataTaskWithURL:(NSURL * __nullable)url completionHandler:(void (^__nullable)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

@end