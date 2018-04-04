//
//  ViewController.m
//  LoginButton
//
//  Created by 叶敬光 on 2017/5/4.
//  Copyright © 2017年 Bill. All rights reserved.
//

#import "ViewController.h"
#import "LoginButton.h"
#import "JFButton.h"
#define ScreenWidth       [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

/**  */
@property (nonatomic, strong) LoginButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat w = ScreenWidth * 690 / 750;
    CGFloat h = 80 / 2;
    CGFloat x = (ScreenWidth - w)/2;
    CGFloat y = 150;
    
    self.btn = [LoginButton buttonWithFrame:CGRectMake(x, y, w, h) title:@"登录" loadingTitle:@"登录..."];
    [self.btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    
    JFButton *jfBtn = [JFButton buttonWithFrame:CGRectMake(x, y + 200, w, h) title:@"无loading按钮"];
    [jfBtn addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jfBtn];
}

- (void)sel:(UIButton *)sender {
    sender.selected = YES;
}

- (void)start {
    [self.btn start];
}

- (IBAction)stopBtnAction:(id)sender {
    [self.btn stop];
}
- (IBAction)disableAction:(id)sender {
    [self.btn disable];
}



@end
