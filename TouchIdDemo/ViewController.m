//
//  ViewController.m
//  TouchIdDemo
//
//  Created by hasegroup on 2019/2/28.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

#import "ViewController.h"
#import "TouchIdDemo-Swift.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SVProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
        
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColor.redColor;
    button.frame = CGRectMake(100, 100, 100, 100);
    button.center = self.view.center;
    [button setBackgroundImage:[UIImage imageNamed:@"love"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
    
}

- (void)buttonAction{
    
    MFBiomeTricsManger *manger = [MFBiomeTricsManger sharedInstance];
    manger.startVerificationBlock = ^{
        
        NSLog(@"开始验证");
    };

    manger.sucessBlock = ^{
        
        NSLog(@"验证成功");
        [SVProgressHUD showSuccessWithStatus:@"验证成功"];
    };
    manger.userCancelBlock = ^{
        
        NSLog(@"用户取消验证");
        [SVProgressHUD showErrorWithStatus:@"用户取消验证"];
    };
    manger.authenticationFailedBlock = ^{
        
        NSLog(@"三次授权失败");
        [SVProgressHUD showErrorWithStatus:@"三次授权失败"];
    };
    manger.passcodeNotSetBlock = ^{
        
        NSLog(@"系统未设置密码");
        [SVProgressHUD showErrorWithStatus:@"系统未设置密码"];
    };
    manger.touchIDNotAvailableBlock = ^{
    
        NSLog(@"设备TouchID/FaceID不可用，例如 打开");
        [SVProgressHUD showErrorWithStatus:@"设备TouchID/FaceID不可用"];
    };
    manger.touchIDNotEnrolledBlock = ^{
        
        NSLog(@"设备TouchID/FaceID不可用，用户未录入");
        [SVProgressHUD showErrorWithStatus:@"设备TouchID/FaceID不可用，用户未录入"];
    };
    manger.userFallbackBlock = ^{
        
        NSLog(@"用户选择输入密码，切换主线程处理");
        [SVProgressHUD showErrorWithStatus:@"用户选择输入密码，切换主线程处理"];
    };
    manger.touchIDLockoutBlock = ^{
        
        NSLog(@"次数超限 锁屏 需要输入密码重新启用touchID");
        [SVProgressHUD showErrorWithStatus:@"次数超限 锁屏 需要输入密码重新启用touchID"];
    };
    [manger mfVerification];
}

- (void)oneDelegateFunc{
    
    NSLog(@"通咯");
}

@end
