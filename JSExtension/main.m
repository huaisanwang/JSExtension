//
//  main.m
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "JSUser.h"
#import "NSObject+JSProperty.h"
#import "NSObject+JSKeyValue.h"
#import "JSConst.h"
#import "JSStatus.h"
#import "JSStatusResult.h"
#import "JSAd.h"
#import "IDAndDescription.h"

void running(void (*fn)(), NSString *comment);
void keyValues2Object();
void keyValuesString2Object();
void fuzaKeyValues2Object();
void dictArrayValues2Object();
void idAndDescription2Object();

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        running(keyValues2Object, @"简单字典->模型");
        running(keyValuesString2Object, @"json字符串->模型");
        running(fuzaKeyValues2Object, @"复杂字典->模型");
        running(dictArrayValues2Object, @"含有数组的字典->MODEL");
        running(idAndDescription2Object, @"idAndDescription...->model");
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

void idAndDescription2Object()
{
    NSDictionary *dict = @{
                           @"id" : @"Jack",
                           @"description" : @"lufy.png",
                           };
    
    IDAndDescription *result = [IDAndDescription objectWithKeyValues:dict];
//    NSLog(@"%@,%@",result.ID,result.Description);
}

void dictArrayValues2Object()
{
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.json001.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.json002.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    // 2.将字典转为StatusResult模型
    JSStatusResult *result = [JSStatusResult objectWithKeyValues:dict];
    
    
    
    // 3.打印StatusResult模型的简单属性
//    NSLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld", result.totalNumber, result.previousCursor, result.nextCursor);
    
    // 4.打印statuses数组中的模型属性
    
//    NSLog(@"打印微博数据....");
    for (JSStatus *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
//        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    // 5.打印ads数组中的模型属性
//    NSLog(@"打印广告数据....");
    for (JSAd *ad in result.ads) {
//        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
}

void fuzaKeyValues2Object()
{
    //复杂字典
    NSDictionary *dict = @{
                           @"text" : @"是啊，今天天气确实不错！",
                           
                           @"user" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           
                           @"retweetedStatus" : @{
                                   @"text" : @"今天天气真不错！",
                                   
                                   @"user" : @{
                                           @"name" : @"Rose",
                                           @"icon" : @"nami.png"
                                           }
                                   }
                           };
    
    JSStatus *status = [JSStatus objectWithKeyValues:dict];
    // 3.打印JSStatus的属性
    NSString *text = status.text;
    NSString *name = status.user.name;
    NSString *icon = status.user.icon;
//    NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    
    // 4.打印JSStatus.retweetedStatus的属性
    NSString *text2 = status.retweetedStatus.text;
    NSString *name2 = status.retweetedStatus.user.name;
    NSString *icon2 = status.retweetedStatus.user.icon;
//    NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
}

void keyValuesString2Object()
{
    NSString *jsonString = @"{\"name\":\"json\",\"icon\":\"jsonfly.png\",\"age\":\"20\"}";
    JSUser *user =[JSUser objectWithKeyValues:jsonString];
//    JSExtLog(@"name=%@, icon=%@, age=%zd, height=%f, money=%@, sex=%d, gay=%d", user.name, user.icon, user.age, user.height, user.money, user.sex, user.gay);
}

void keyValues2Object()
{
    //test by json.wang
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @"20",
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"gay" : @"1"
                           };
    //读取user类的属性
    JSUser *user = [JSUser objectWithKeyValues:dict];
//    JSExtLog(@"name=%@, icon=%@, age=%zd, height=%f, money=%@, sex=%d, gay=%d", user.name, user.icon, user.age, user.height, user.money, user.sex, user.gay);
}

void running(void (*fn)(),NSString *commnet)
{
//    JSExtLog(@"%@",commnet);
    fn();
//    JSExtLog(@"%@",commnet);
}

//=====
//      普通属性只有加了@package的局部成员才能使用->访问符访问
//            JSUser *user = [[JSUser alloc] init];
//            user->_weight=20;
//===
//            JSUser *juser =[JSUser new];
//            juser.name = dict[@"name"];
//            NSLog(@"--->%@",juser.name);
    
