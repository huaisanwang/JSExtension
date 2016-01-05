//
//  IDAndDescription.m
//  JSExtension
//
//  Created by JsonWang on 16/1/4.
//  Copyright © 2016年 JsonWang. All rights reserved.
//

#import "IDAndDescription.h"

@implementation IDAndDescription

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"Description":@"description"
             };
}
@end
