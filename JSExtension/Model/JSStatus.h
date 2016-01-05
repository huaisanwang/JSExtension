//
//  JSStatus.h
//  JSExtension
//
//  Created by JsonWang on 16/1/4.
//  Copyright © 2016年 JsonWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSUser;

@interface JSStatus : NSObject

@property(copy,nonatomic) NSString *text;
@property(nonatomic,strong) JSUser *user;
@property(nonatomic,strong) JSStatus *retweetedStatus;

@end
