//
//  JSConst.h
//  JSExtension
//
//  Created by JsonWang on 15/12/30.
//  Copyright © 2015年 JsonWang. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define JSExtLog(...) NSLog(__VA_ARGS__)
#else
#define JSExtLog(...)
#endif

extern NSString *const JSPropertyTypeInt;
extern NSString *const JSPropertyTypeShort;
extern NSString *const JSPropertyTypeFloat;
extern NSString *const JSPropertyTypeDouble;
extern NSString *const JSPropertyTypeLong;
extern NSString *const JSPropertyTypeLongLong;
extern NSString *const JSPropertyTypeChar;
extern NSString *const JSPropertyTypeBOOL1;
extern NSString *const JSPropertyTypeBOOL2;
extern NSString *const JSPropertyTypePointer;

extern NSString *const JSPropertyTypeIvar;
extern NSString *const JSPropertyTypeMethod;
extern NSString *const JSPropertyTypeBlock;
extern NSString *const JSPropertyTypeClass;
extern NSString *const JSPropertyTypeSEL;
extern NSString *const JSPropertyTypeId;

