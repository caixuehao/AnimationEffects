//
//  LuaTestViewController.m
//  AnimationEffects
//
//  Created by cxh on 16/11/11.
//  Copyright © 2016年 cxh. All rights reserved.
//

#import "LuaTestViewController.h"
#import <wax.h>

@implementation LuaTestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    wax_start(nil,nil);
    NSString* str = @"print('hello wax')";
    
    
    wax_runLuaString([str UTF8String]);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
    
}

@end
