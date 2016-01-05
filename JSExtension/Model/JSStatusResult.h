//
//  JSStatusResult.h
//  JSExtension
//
//  Created by JsonWang on 16/1/4.
//  Copyright © 2016年 JsonWang. All rights reserved.
//  微博数据类-包含微博和广告以及其他属性

#import <Foundation/Foundation.h>
#import "JSBaseObject.h"

@interface JSStatusResult : JSBaseObject
@property(nonatomic,strong) NSMutableArray *statuses;  //微博
@property(nonatomic,strong) NSMutableArray *ads;    //广告
@property(nonatomic,strong) NSNumber *totalNumber;  //总数
@property(nonatomic,assign) long long previousCursor; //上一页
@property(nonatomic,assign) long long nextCursor;  //下一页
@end
