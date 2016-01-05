//
//  JSPropertyType.m
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import "JSPropertyType.h"
#import "JSConst.h"
#import "NSObject+JSProperty.h"

@implementation JSPropertyType
static NSMutableDictionary *cachedTypes_;

+(void)load
{
    cachedTypes_ = [NSMutableDictionary dictionary];
}

+(instancetype)propertyTypeWithAttributeString:(NSString *)string
{
    
    return [[JSPropertyType alloc] initWithTypeString:string];
}

-(instancetype)initWithTypeString:(NSString *)string
{
    NSUInteger loc =1;
    NSUInteger len = [string rangeOfString:@","].location - loc;
    NSString *typeCode = [string substringWithRange:NSMakeRange(loc, len)];
    
    if (!cachedTypes_[typeCode]) {
//        NSLog(@"%@",typeCode);
        self=[super init];
        [self getTypeCode:typeCode];
        cachedTypes_[typeCode]=self;
    }
    return self;
}

-(void)getTypeCode:(NSString *)typeCode
{
    //-------------
//    NSLog(@"%@",typeCode);
    //========================
    _code = typeCode;
    if ([typeCode isEqualToString:JSPropertyTypeId]) {
        _idType = YES;
    }else if (typeCode.length>3 && [typeCode hasPrefix:@"@\""]){
        _code = [typeCode substringWithRange:NSMakeRange(2, typeCode.length-3)];
        _typeClass = NSClassFromString(_code);
        _numberType = (_typeClass == [NSNumber class] || [_typeClass isSubclassOfClass:[NSNumber class]]);
        _fromFoundation = [NSObject isClassFromFoundation:_typeClass];
    }
    
    NSString *lowerCode = _code.lowercaseString;
    NSArray *numberTypes = @[JSPropertyTypeInt, JSPropertyTypeShort, JSPropertyTypeBOOL1,JSPropertyTypeBOOL2, JSPropertyTypeFloat, JSPropertyTypeDouble, JSPropertyTypeLong, JSPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        
        if ([lowerCode isEqualToString:JSPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}
@end
