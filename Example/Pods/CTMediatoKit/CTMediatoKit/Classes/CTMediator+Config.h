//
//  CTMediator+Config.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (Config)

- (void)configAuthCode:(NSString *)authCode;
- (NSString *)fetchAuthCode;

- (void)configQQText:(NSString *)qqText;
- (NSString *)fetchQQText;

- (void)configEmail:(NSString *)email;
- (NSString *)fetchEmailText;

- (void)configLogin:(BOOL)isLogin;
- (BOOL)fetchIsLogin;

- (void)configAppKey:(NSString *)appKey;
- (NSString *)fetchAppKey;

- (void)configAppID:(NSString *)appID;
- (NSString *)fetchAPPID;

- (void)configIsActive:(BOOL)isActive;
- (BOOL)fetchIsActive;

- (void)configAccessToken:(NSString *)accessToken;
- (NSString *)fetchAccessToken;

- (void)configRetryCount:(NSInteger)count;
- (NSInteger)fetchRetryCount;

- (void)configIsRefreshing:(BOOL)isRefresh;
- (BOOL)fetchIsRefresh;

@end

NS_ASSUME_NONNULL_END
