//
//  AppDelegate.m
//  AnimationEffects
//
//  Created by cxh on 16/11/1.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MainNavigationController.h"
#import <CommonCrypto/CommonDigest.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController* mainViewController = [[MainViewController alloc] init];
    self.window.rootViewController = [[MainNavigationController alloc] initWithRootViewController:mainViewController];
    [self.window makeKeyAndVisible];
     return YES;
    
    //UmWJ4UC22ENujir1MA2opA
     char str1[] = "1272134953352671";
     char str2[] = "3go8&$8*3*3h0k(2)2";
    
    for (int i = 0;  i < strlen(str1); ++i) {
        str1[i] = str1[i]^str2[i%strlen(str1)];
    }
    NSLog(@"%s",str1);
    
    const char *original_str = str1;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSLog(@"%s",result);
    
    
    NSData *nsdata = [[NSString stringWithFormat:@"%s",result]  dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:3];
    NSLog(@"%@",base64Encoded);
    
    base64Encoded = [base64Encoded stringByReplacingOccurrencesOfString:@"/" withString:@"+"];
    base64Encoded = [base64Encoded stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
    
    NSLog(@"%@",base64Encoded);
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
