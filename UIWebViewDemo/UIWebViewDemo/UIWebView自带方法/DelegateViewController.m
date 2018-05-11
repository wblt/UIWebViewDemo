//
//  DelegateViewController.m
//  UIWebViewDemo
//
//  Created by 任鹏 on 2018/5/2.
//  Copyright © 2018年 huyang. All rights reserved.
//

#import "DelegateViewController.h"

@interface DelegateViewController ()<UIWebViewDelegate>
/**webView*/
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"原生交互";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"变颜色" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"indexDemo" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    self.webView = webView;
}

- (void)onClickedOKbtn
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"cli()"];
}
/**使用UIWebView自带方法进行js调用OC的时候,在这个方法中讲oc方法注入js*/
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /**获取点击页面加载的url,此url为前端与移动端约定好的,比如这个demo,约定好的请求头就是'demo',然后在'://后面添加不同的字段来判断不同的事件,可以看indexDemo.html中的js写法'*/
    NSString *requestString = request.URL.absoluteString;
    
    /**以'://将URL分割'*/
    NSArray *tmpArr = [requestString componentsSeparatedByString:@"://"];
    if ([tmpArr.firstObject isEqualToString:@"demo"]) {
        /**通过不同的字段来进行不同的事件处理*/
        if ([tmpArr.lastObject isEqualToString:@"goSleep"]) {
            [self AlertWithStr:@"去睡觉吧"];
        } else if ([tmpArr.lastObject isEqualToString:@"goEat"]) {
            [self AlertWithStr:@"去吃饭吧"];
        } else if ([tmpArr.lastObject isEqualToString:@"goDrink"]) {
            [self AlertWithStr:@"去喝水吧"];
        }
        return NO;
    }
    return YES;
}

- (void)AlertWithStr:(NSString *)str
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"show" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
