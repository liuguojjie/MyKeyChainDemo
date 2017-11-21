//
//  LGJKeyChainTools.m
//  MyInAppPurchasesTest
//
//  Created by LGJ on 2017/11/10.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "LGJKeyChainTools.h"
@implementation LGJKeyChainTools

+ (NSString *)objectForService:(NSString *)serviceName account:(NSString *)account {
    
    LGJKeyChainQuery *query = [[LGJKeyChainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch];
    return query.saveObject;
}

+ (BOOL)deleteObjectForService:(NSString *)serviceName account:(NSString *)account{
    
    LGJKeyChainQuery *query = [[LGJKeyChainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    
    return [query deleteItem];
}

+ (BOOL)setObject:(NSString *)object forService:(NSString *)serviceName account:(NSString *)account{
    
    LGJKeyChainQuery *query = [[LGJKeyChainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.saveObject = object;
    
    return [query save];
}

+ (NSArray *)findAccountWithService:(NSString *)service{
    
    
    LGJKeyChainQuery *query = [[LGJKeyChainQuery alloc] init];
    
    query.service = service;
    
    return [query fetchAll];
    
}
@end
