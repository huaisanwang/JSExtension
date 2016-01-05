//
//  JSUser.h
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface JSUser : NSObject
{
    @package
    double _weight;
}

/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *icon;
/** 年龄 */
@property (assign, nonatomic) unsigned int age;
/** 身高 */
@property (assign, nonatomic) float height;
/** 财富 */
@property (strong, nonatomic) NSNumber *money;
/** 性别 */
@property (assign, nonatomic) Sex sex;
/** 同性恋 */
@property (assign, nonatomic, getter=isGay) BOOL gay;

@property (nonatomic, assign) char test;

@end
