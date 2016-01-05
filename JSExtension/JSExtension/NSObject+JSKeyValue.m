//
//  NSObject+JSKeyValue.m
//  JSExtension
//
//  Created by JsonWang on 15/12/31.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import "NSObject+JSKeyValue.h"
#import "JSProperty.h"

@implementation NSObject (JSKeyValue)

/**
 *  根据字典返回...
 *
 *  @param keyValues 源字典
 *
 *  @return ...
 */
+(instancetype)objectWithKeyValues:(id)keyValues
{
    if(!keyValues) return nil;
    return [[[self alloc] init] setKeyValues:keyValues];
}

+(NSString *)propertyKey:(NSString *)keyName
{
    NSString *key;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self replacedKeyFromPropertyName][keyName];
    }
    
    return key?:keyName;
}
//self.class 为当前的模型对象,如JSUser,keyValues为传过来的字典
-(instancetype)setKeyValues:(id)keyValues
{
    //对传过来的keyValues进行处理,将json字符串或者字典转换成Foundation框架中的对象
    keyValues =[keyValues JSONObject];

    //调用NSObject+JSProperty的类方法,返回当然模型类的属性和属性的数据类型
    NSArray *propertiesArray = [self.class properties];
    for (JSProperty *property in propertiesArray) {
        // 通过键查找字典里的值
        // tihuan
        id value =[keyValues valueForKey:[self.class propertyKey:property.name]];
        if(!value) continue;
        
        //拿到值后将值的类型转换为属性对应的数据类型
        JSPropertyType *type = property.type;
        Class typeClass = type.typeClass;
        
        if (typeClass && !type.isFromFoundation) {
            value =[typeClass objectWithKeyValues:value];
            //是否实现协议方法
        }else if([self.class respondsToSelector:@selector(objectClassInArray)]){
            id objectClass;
            objectClass = [self.class objectClassInArray][property.name];
            if ([objectClass isKindOfClass:[NSString class]]) {
                objectClass = NSClassFromString(objectClass);
            }
            if (objectClass) {
                value = [objectClass objectArrayWithKeyValuesArray:value];
            }
        }else if (type.isNumberType) {
            NSString *oldValue = value;
            //如果是字符串型的数字 @"12"
            if ([value isKindOfClass:[NSString class]]) {
                value = [[[NSNumberFormatter alloc] init] numberFromString:value];
            }
            if (type.isBoolType) {
                NSString *lower = [oldValue lowercaseString];
                if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) {
                    value = @YES;
                }else if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]){
                    value = @NO;
                }
            }
        }else{
            if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    if(type.isNumberType) value = [value description];
                }else if ([value isKindOfClass:[NSURL class]]){
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
            }
        }
        [self setValue:value forKey:property.name];
    }
    return self;
}



/**
 *  根据字典/JSON返回模型数组
 *
 *  @param keyValuesArray 字典/JSON数组
 *
 *  @return 模型数组
 */
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray{
    
    if ([self isClassFromFoundation:self])
        return keyValuesArray;
    
    keyValuesArray = [keyValuesArray JSONObject];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 遍历
    for (NSDictionary *keyValues in keyValuesArray) {
        id model;
        model = [self objectWithKeyValues:keyValues];
        if (model) {
            [modelArray addObject:model];
        }
    }
    
    return modelArray;
    
}
#pragma  该方法当前就再NSObject+JSKeyValue 类别文件当中,所以任何Object的子类都能调用
/**
 *  JSON字符串转JSON对象
 *
 *  @return Foundation JSON-object
 */
-(id)JSONObject
{
    id foundationObj;
    if ([self isKindOfClass:[NSString class]]) {
        foundationObj = [NSJSONSerialization JSONObjectWithData:[(NSString *)self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }else if ([self isKindOfClass:[NSData class]]){
        foundationObj =[NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    
    return foundationObj?:self;
}
@end
