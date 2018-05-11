//
//  JSCoreViewController.m
//  UIWebViewDemo
//
//  Created by 任鹏 on 2018/5/2.
//  Copyright © 2018年 huyang. All rights reserved.
//

#import "JSCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSExportDemoViewController.h"
@interface JSCoreViewController ()<UIWebViewDelegate>
/**webView*/
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation JSCoreViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO];
    [self.navigationController.toolbar setBarTintColor:[UIColor cyanColor]];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"改变hhhh" style:UIBarButtonItemStylePlain target:self action:@selector(changehhh)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"JSExportDemo" style:UIBarButtonItemStylePlain target:self action:@selector(JSExportDemo)];
    self.toolbarItems = @[left,right];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"jsCore";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"变颜色" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JsCoreDemo" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    self.webView = webView;
}

- (void)JSExportDemo
{
    NSLog(@"JSExportDemo");
    JSExportDemoViewController *js = [[JSExportDemoViewController alloc] init];
    [self.navigationController pushViewController:js animated:YES];
}

- (void)changehhh
{
    JSContext *context=[self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *tmp = @"inputtext('哈哈哈哈哈哈')";
    [context evaluateScript:tmp];
}

- (void)onClickedOKbtn
{
    JSContext *context=[self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *alertJS=@"cli()"; //准备执行的js代码
    [context evaluateScript:alertJS];//通过oc方法调用js的alert
}


- (void)AlertWithStr:(NSString *)str
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"show" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __weak JSCoreViewController *weakSelf = self;
    context[@"go"] = ^(id str){
        /**不要在block内部直接使用JSContext和JSValue,因为Block会强引用它里面用到的外部变量，如果直接在Block中使用JSValue的话，那么这个JSvalue就会被这个Block强引用，而每个JSValue都是强引用着它所属的那个JSContext的,而这个Block又是注入到这个Context中，所以这个Block会被context强引用，这样会造成循环引用，导致内存泄露。不能直接使用JSContext的原因同理。正确的驶入方法如下:*/
        NSArray *tmp = [JSContext currentArguments];
        for (JSValue *m in tmp) {
            NSString *mm = m.toString;
            if ([mm isEqualToString:@"water"]) {
                [weakSelf AlertWithStr:@"去喝水"];
            } else if ([mm isEqualToString:@"sleep"]) {
                [weakSelf AlertWithStr:@"去睡觉"];
            } else if ([mm isEqualToString:@"food"]) {
                [weakSelf AlertWithStr:@"去吃饭"];
            }
        }
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
