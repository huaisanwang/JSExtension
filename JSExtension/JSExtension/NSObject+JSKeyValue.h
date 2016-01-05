//
//  NSObject+JSKeyValue.h
//  JSExtension
//
//  Created by JsonWang on 15/12/31.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JSProperty.h"

@protocol JSKeyValue <NSObject>
@optional
+ (NSDictionary *) objectClassInArray;
+(NSDictionary *)replacedKeyFromPropertyName;
@end

/**
 *  分类实现了某个协议,那么NSObject类就实现了该协议,要用的时候调用协议方法即可
 */
@interface NSObject (JSKeyValue)<JSKeyValue>

+(instancetype)objectWithKeyValues:(id)keyValues;

@end
