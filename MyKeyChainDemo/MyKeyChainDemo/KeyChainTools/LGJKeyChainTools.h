//
//  LGJKeyChainTools.h
//  MyInAppPurchasesTest
//
//  Created by LGJ on 2017/11/10.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "LGJKeyChainQuery.h"
#import <Foundation/Foundation.h>

@interface LGJKeyChainTools : NSObject

/**
 *  读取保存的数据
 *
 *  @param serviceName serviceName
 *  @param account     account
 *
 *  @return 以string形式的数据
 */

+ (NSString *)objectForService:(NSString *)serviceName account:(NSString *)account;

/**
 *  删除保存的数据
 *
 *  @param serviceName service name
 *  @param account     account
 *
 *  @return 删除状态：成功：YES；失败：NO
 */

+ (BOOL)deleteObjectForService:(NSString *)serviceName account:(NSString *)account;

/**
 *  保存数据
 *
 *  @param object    object
 *  @param serviceName service name
 *  @param account     account
 *
 *  @return 保存状态：成功：YES；失败：NO
 */
+ (BOOL)setObject:(NSString *)object forService:(NSString *)serviceName account:(NSString *)account;

+ (NSArray *)findAccountWithService:(NSString *)service;
@end
