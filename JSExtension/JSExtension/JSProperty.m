//
//  JSProperty.m
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import "JSProperty.h"

#import "JSPropertyType.h"

@implementation JSProperty

+(instancetype)propertyWithProperty:(objc_property_t)property
{
    return [[JSProperty alloc] initWithProperty:property];
}

-(instancetype)initWithProperty:(objc_property_t)property
{
    if (self = [super init]) {
        _name = @(property_getName(property));
        //对property_getAttributes()获取到的字符串如:T@"NSString",C,N,V_uuu 进行切割
        //获取到NSString和C进行数据类型确认
        _type = [JSPropertyType propertyTypeWithAttributeString:@(property_getAttributes(property))];
    }
    return self;
}
@end
