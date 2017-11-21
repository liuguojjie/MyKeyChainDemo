//
//  LGJKeyChainQuery.m
//  MyInAppPurchasesTest
//
//  Created by LGJ on 2017/11/10.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "LGJKeyChainQuery.h"
@implementation LGJKeyChainQuery

/**
 *  保存数据
 *
 *  @return 保存状态：成功 YES；失败：NO
 */
- (BOOL)save {
    
    NSMutableDictionary *query = nil;
    
    NSMutableDictionary *searchQuery = [self query];
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, nil);
    
    if (status == errSecSuccess) {//item 已经存在，更新它
        
        query = [[NSMutableDictionary alloc] init];
        [query setObject:self.saveObjectData forKey:(__bridge id)kSecValueData];
         status = SecItemUpdate((__bridge CFDictionaryRef)searchQuery, (__bridge CFDictionaryRef)query);//核心API 更新数据！
        
    }else{//item未找到，创建它
        
        query = [self query];
        
        NSLog(@"self.saveObjectData  == %@",self.saveObjectData);
        [query setObject:self.saveObjectData forKey:(__bridge id)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }
    
    return (status == errSecSuccess);
    
}

/**
 *  删除keychain items
 *
 *  @return 删除状态：成功 YES；失败：NO
 */

- (BOOL)deleteItem {
    
    NSMutableDictionary *dict = [self query];
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dict);//核心API 删除数据！
    
    return (status == errSecSuccess);
}
/**
 *  获取存储的数据
 *
 *  @return 获取状态：成功 YES；失败：NO
 */
-(BOOL)fetch {
    
    //配置查询用的可变字典
    CFTypeRef result = NULL;
    NSMutableDictionary *query = [self query];
    [query setObject:@YES forKey:(__bridge id)kSecReturnData];//返回Data
    [query setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    //查询
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);//核心API 查找是否匹配 和返回数据！
    
    if(status != errSecSuccess){
        
        return NO;
    }
    
    //返回数据
    self.saveObjectData = (__bridge_transfer NSData *)result;
    
    return YES;
}

- (NSArray *)fetchAll{
    
    NSMutableDictionary *query = [self query];
    
    [query setObject:@YES forKey:(__bridge id)kSecReturnAttributes];
    
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    
    CFTypeRef result = NULL;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    
    if (status != errSecSuccess) {
       
        return nil;
        
    }else{
        
        NSArray<NSDictionary *> *resultArray = (__bridge NSArray<NSDictionary *> *)result;
        if (resultArray.count == 0) return @[];
        
        NSMutableArray *accountArr = [NSMutableArray array];
        
        for(NSDictionary *dict in resultArray) {
            
            NSString *account  = dict[(__bridge id)kSecAttrAccount];
            
            if (account.length > 0) {
                
                LGJKeyChainQuery *KeyChainQuery  = [[LGJKeyChainQuery alloc] init];
                KeyChainQuery.account = account;
                [accountArr addObject:KeyChainQuery];
            }
        }
       
        return accountArr;
    }
}

#pragma mark - 存取器方法

- (void)setSaveObject:(NSString *)saveObject
{
    
    //self.saveObjectData = [GTMBase64 decodeString:saveObject];
    
   // self.saveObjectData = [[NSData alloc] initWithBase64EncodedString:saveObject options:0];
                           
    self.saveObjectData = [saveObject dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)saveObject
{
    if ([self.saveObjectData length]) {

       // return [GTMBase64 stringByEncodingData:self.saveObjectData];
        
        return[[NSString alloc] initWithData:self.saveObjectData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

/**
 keychain 需要的dictionary
 
 @return keychain dictionary
 */

- (NSMutableDictionary *)query{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];//表明为一般密码可能是证书或者其他东西
    
    if (self.service) {
        
        [dictionary setObject:self.service forKey:(__bridge id)kSecAttrService];//输入service
    }
    
    if (self.account) {
        
        [dictionary setObject:self.account forKey:(__bridge id)kSecAttrAccount];//输入account
    }
    
    return dictionary;
}
@end
