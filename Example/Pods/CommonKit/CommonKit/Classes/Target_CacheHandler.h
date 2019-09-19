//
//  Target_CacheHandler.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_CacheHandler : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic, copy) NSString *authCode;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *qqText;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appID;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) NSInteger retryCount;
@property (nonatomic, assign) BOOL isRefresh;

- (void)Action_setUpAuthCode:(NSDictionary *)parameter;
- (NSString *)Action_loadAuthCode:(NSDictionary *)parameter;

- (void)Action_setUpQQText:(NSDictionary *)parameter;
- (NSString *)Action_loadQQText:(NSDictionary *)parameter;

- (void)Action_setUpEmail:(NSDictionary *)parameter;
- (NSString *)Action_loadEmail:(NSDictionary *)parameter;

- (void)Action_setUpLogin:(NSDictionary *)parameter;
- (BOOL)Action_loadLogin:(NSDictionary *)parameter;

- (void)Action_setUpAppKey:(NSDictionary *)parameter;
- (NSString *)Action_loadAppKey:(NSDictionary *)parameter;

- (void)Action_setUpAppID:(NSDictionary *)parameter;
- (NSString *)Action_loadAppId:(NSDictionary *)parameter;

- (void)Action_setupActive:(NSDictionary *)parameter;
- (BOOL)Action_loadActive:(NSDictionary *)parameter;

- (void)Action_setUpAccessToken:(NSDictionary *)parameter;
- (NSString *)Action_loadAccessToken:(NSDictionary *)paramete;

- (void)Action_setUpRetryCount:(NSDictionary *)parameter;
- (NSInteger )Action_loadRetryCount:(NSDictionary *)paramete;

- (void)Action_setupRefresh:(NSDictionary *)parameter;
- (BOOL )Action_loadRefresh:(NSDictionary *)paramete;
@end

NS_ASSUME_NONNULL_END
