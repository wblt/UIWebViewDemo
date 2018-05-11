//
//  SDKViewController.m
//  UIWebViewDemo
//
//  Created by 任鹏 on 2018/5/2.
//  Copyright © 2018年 huyang. All rights reserved.
//

#import "SDKViewController.h"
#import <WebViewJavascriptBridge.h>
@interface SDKViewController ()

/**WebViewJavascriptBridge*/
@property (nonatomic, strong)WebViewJavascriptBridge *bridge;

@end

@implementation SDKViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO];
    [self.navigationController.toolbar setBarTintColor:[UIColor cyanColor]];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"改变hhhh" style:UIBarButtonItemStylePlain target:self action:@selector(changehhh)];
    self.toolbarItems = @[left];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WebViewJavascriptBridge";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"变颜色" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self addWebView];
}

- (void)addWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [self.bridge setWebViewDelegate:self];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebViewJavascriptBridgeDemo" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [self jsCalliOS];
}


- (void)jsCalliOS
{
    [self.bridge registerHandler:@"go" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data[@"id"] isEqualToString:@"sleep"]) {
            [self AlertWithStr:@"去睡觉" responseCallback:responseCallback];
        } else if ([data[@"id"] isEqualToString:@"food"]) {
            [self AlertWithStr:@"去吃饭" responseCallback:responseCallback];
        } else if ([data[@"id"] isEqualToString:@"water"]) {
            [self AlertWithStr:@"去喝水" responseCallback:responseCallback];
        }
    }];
}
- (void)AlertWithStr:(NSString *)str responseCallback:(WVJBResponseCallback)responseCallback
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"show" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        responseCallback(str);
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)onClickedOKbtn
{
    [self.bridge callHandler:@"chageColor"];
}

- (void)changehhh
{
    [self.bridge callHandler:@"changeHH" data:@"你好,我是胡杨" responseCallback:^(id responseData) {
        NSLog(@"%@",responseData);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
