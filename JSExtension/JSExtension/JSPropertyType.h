//
//  JSPropertyType.h
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSPropertyType : NSObject
@property (nonatomic, copy) NSString *code;
@property(nonatomic,readonly,getter=isIdType) BOOL idType;
@property(nonatomic,readonly,getter=isNumberType) BOOL numberType;
@property(nonatomic,readonly,getter=isBoolType) BOOL boolType;
@property(nonatomic,readonly) Class typeClass;
@property(nonatomic,readonly,getter=isFromFoundation) BOOL fromFoundation;
+(instancetype)propertyTypeWithAttributeString:(NSString *)string;
@end
