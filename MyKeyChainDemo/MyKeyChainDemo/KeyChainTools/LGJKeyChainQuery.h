//
//  LGJKeyChainQuery.h
//  MyInAppPurchasesTest
//
//  Created by LGJ on 2017/11/10.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGJKeyChainQuery : NSObject

/**
 *  kSecAttrService
 */
@property (nonatomic, copy) NSString *service;

/**
 *  kSecAttrAccount
 */
@property (nonatomic, copy) NSString *account;

/**
 *  要存储的数据 (string)
 */

@property (nonatomic, strong) NSString *saveObject;

/**
 *  要存储的数据 (NSData)
 */
@property (nonatomic, strong) NSData *saveObjectData;

/**
 *  保存数据
 *
 *  @return 保存状态：成功 YES；失败：NO
 */
- (BOOL)save;

/**
 *  删除keychain items
 *
 *  @return 删除状态：成功 YES；失败：NO
 */
- (BOOL)deleteItem;

/**
 *  获取存储的数据
 *
 *  @return 获取状态：成功 YES；失败：NO
 */
- (BOOL)fetch;

- (NSArray*)fetchAll;
@end
