//
//  LuaTestViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/11.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "LuaTestViewController.h"
#import "Macro.h"
#import <wax/wax.h>
static LuaTestViewController* shareLuaTestViewController = nil;
@implementation LuaTestViewController
+(NSString*)getString{
    return @"hello wax";
}
+(LuaTestViewController*)share{
    @synchronized(self){  //为了确保多线程情况下，仍然确保实体的唯一性
        if (!shareLuaTestViewController) {
           shareLuaTestViewController = [[self alloc] init];
        }
    }
    return shareLuaTestViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorRGB(123, 123, 231);
    NSString* str =
    @"require \"LoginViewController\"     \
    loginVC = LoginViewController:init();   \
    luaTestVC = LuaTestViewController:share();\
    luaTestVC:view():setBackgroundColor(UIColor:orangeColor());\
    luaTestVC:navigationController():pushViewController_animated(loginVC,true);\
    loginVC:login()";
    wax_runLuaString([str UTF8String]);

//    UIViewController* rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [rootVC.view addSubview:view];
    
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"LuaTest" ofType:@"lua"];
//    NSLog(@"%@",path);
//    NSString* str = [NSString stringWithContentsOfFile:path encoding:4 error:nil];
//    NSLog(@"%@",str);
//    wax_runLuaString([str UTF8String]);
//    wax_runLuaFile([path UTF8String]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
    
}

@end
