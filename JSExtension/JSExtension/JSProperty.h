//
//  JSProperty.h
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSPropertyType.h"
#import <objc/runtime.h>

@interface JSProperty : NSObject

@property(nonatomic,readonly) NSString *name;
@property(nonatomic,readonly) JSPropertyType *type;

+(instancetype)propertyWithProperty:(objc_property_t)property;

@end
