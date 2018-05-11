//
//  DemoModel.h
//  UIWebViewDemo
//
//  Created by 任鹏 on 2018/5/8.
//  Copyright © 2018年 huyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol DemoModelProtocol <JSExport>

/**这个方法得命名需要注意,
 OC的方法名字应该与js名字统一,
 OC:- (void)name:(NSString *)name Something:(NSString *)something;
 js:<input type="button" id="food" onclick="test.nameSomething('B','去吃饭')" class="btn" value="去吃饭" />
 
 OC:- (void)test;
 js:<input type="button" id="sleep" onclick="test.test()" class="btn" value="去睡觉" />
 */
- (void)name:(NSString *)name Something:(NSString *)something;
- (void)test;

@end

@interface DemoModel : NSObject <DemoModelProtocol>


/**VC*/
@property (nonatomic, weak)UIViewController *VC;
@end
