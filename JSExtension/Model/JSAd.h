//
//  JSAd.h
//  JSExtension
//
//  Created by JsonWang on 16/1/4.
//  Copyright © 2016年 JsonWang. All rights reserved.
//  广告模型类

#import <Foundation/Foundation.h>

@interface JSAd : NSObject
/** 广告图片 */
@property (copy, nonatomic) NSString *image;
/** 广告url */
@property (strong, nonatomic) NSURL *url;
@end
