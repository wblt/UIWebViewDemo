//
//  JSExportDemoViewController.m
//  UIWebViewDemo
//
//  Created by 任鹏 on 2018/5/8.
//  Copyright © 2018年 huyang. All rights reserved.
//

#import "JSExportDemoViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "DemoModel.h"
@interface JSExportDemoViewController ()<UIWebViewDelegate>
/**webView*/
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation JSExportDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JSExportDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSExportDemo" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    self.webView = webView;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];  
    DemoModel *model = [[DemoModel alloc] init];
    model.VC = self;
    context[@"test"] = model;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
