//
//  DemoModel.m
//  UIWebViewDemo
//
//  Created by 任鹏 on 2018/5/8.
//  Copyright © 2018年 huyang. All rights reserved.
//

#import "DemoModel.h"

@implementation DemoModel
- (void)name:(NSString *)name Something:(NSString *)something
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:name message:something preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [_VC presentViewController:alert animated:YES completion:nil];
}

- (void)test
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"试试" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [_VC presentViewController:alert animated:YES completion:nil];
}
@end
