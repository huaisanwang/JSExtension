//
//  JSStatusResult.m
//  JSExtension
//
//  Created by JsonWang on 16/1/4.
//  Copyright © 2016年 JsonWang. All rights reserved.
//

#import "JSStatusResult.h"

@implementation JSStatusResult

+(NSDictionary *)objectClassInArray
{
    return @{
             @"statuses":@"JSStatus",
             @"ads":@"JSAd"
             };
}
@end
