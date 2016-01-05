//
//  NSObject+JSProperty.m
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import "NSObject+JSProperty.h"
#import <objc/runtime.h>
#import "JSProperty.h"


@implementation NSObject (JSProperty)
static NSMutableDictionary *cachedProperties_;
static NSSet *foundationClasses_;

+(void)load
{
    cachedProperties_ =[NSMutableDictionary dictionary];
}

+(NSSet *)foundationClasses
{
    
    if (foundationClasses_ == nil) {
        foundationClasses_ =[NSSet setWithObjects:
                             [NSURL class],
                             [NSDate class],
                             [NSValue class],
                             [NSData class],
                             [NSArray class],
                             [NSDictionary class],
                             [NSString class],
                             [NSAttributedString class],
                             nil];
    }
    return foundationClasses_;
}


/**
 *  找到类中得属有属性
 *
 *  @return 类中的属性列表
 */
+(NSMutableArray *)properties
{
    
    NSMutableArray *cachedProperties =cachedProperties_[NSStringFromClass(self)];
    if (!cachedProperties) {
//        NSLog(@"%@调用了properties方法",[self class]);
        cachedProperties = [NSMutableArray array];
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(self, &outCount);
        
        for (int i=0; i<outCount; i++) {
            objc_property_t property = properties[i];
            JSProperty *propertyObj =[JSProperty propertyWithProperty:property];
            [cachedProperties addObject:propertyObj];
        }
        free(properties); //解决内存泄露问题
        cachedProperties_[NSStringFromClass(self)] = cachedProperties;
    }
    return cachedProperties;
}


+(BOOL)isClassFromFoundation:(Class)c
{
    if (c == [NSObject class]) return YES;
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop =YES;
        }
    }];
    return result;
}

-(void)test1
{
//    typedef struct property_t {
//        const char *name;
//        const char *attributes;
//    } *propertyStruct;
// 2---->
//    //把c字符串转换为oc
//    NSString *name = @(property_getName(property));
//    NSString *attributes =@(property_getAttributes(property));
//    
//    NSUInteger loc =1;
//    NSUInteger len = [attributes rangeOfString:@","].location - loc;
//    NSString *type = [attributes substringWithRange:NSMakeRange(loc, len)];
//    NSLog(@"%@",type);
// 1----->
//    NSArray *propertiesArray = [NSMutableArray array];
//    unsigned int outCount =0;
//    objc_property_t *properties = class_copyPropertyList(self, &outCount);
//    //
//    for (int i=0; i<outCount; i++) {
//        objc_property_t propertyEntity = properties[i];
//        //        NSLog(@"name:%s-->attributes:%s",((propertyStruct)property)->name,((propertyStruct)property)->attributes);
//        NSLog(@"name:%s---attributes:%s",property_getName(propertyEntity),property_getAttributes(propertyEntity));
//        // 以下是控制台输出的内容:
//        //        2015-12-30 15:53:09.492 JSExtension[1928:110440] name:name---attributes:T@"NSString",C,N,V_name
//        //        2015-12-30 15:53:09.493 JSExtension[1928:110440] name:icon---attributes:T@"NSString",C,N,V_icon
//        //        2015-12-30 15:53:09.493 JSExtension[1928:110440] name:age---attributes:TI,N,V_age
//        //        2015-12-30 15:53:09.494 JSExtension[1928:110440] name:height---attributes:Tf,N,V_height
//        //        2015-12-30 15:53:09.494 JSExtension[1928:110440] name:money---attributes:T@"NSNumber",&,N,V_money
//        //        2015-12-30 15:53:09.494 JSExtension[1928:110440] name:sex---attributes:Ti,N,V_sex
//        //        2015-12-30 15:53:09.494 JSExtension[1928:110440] name:gay---attributes:TB,N,GisGay,V_gay
//        
//    }
//    return propertiesArray;
}
@end
