//
//  NSObject+JSProperty.h
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSProperty)
+(NSArray *)properties;
+(BOOL)isClassFromFoundation:(Class)c;
@end
