//
//  CTMediator+Config.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "CTMediator+Config.h"

#define kTargetName @"CacheHandler"
#define kConfigAuthCode @"setUpAuthCode"
#define kFetchAuthCode @"loadAuthCode"
#define kConfigQQText @"setUpQQText"
#define kFetchQQText @"loadQQText"
#define kConfigEmail @"setUpEmail"
#define kFetchEmail @"loadEmail"
#define kConfigLogin @"setUpLogin"
#define kFetchLogin @"loadLogin"
#define kConfigAppKey @"setUpAppKey"
#define kFetchAppKey @"loadAppKey"
#define kConfigAppID @"setUpAppID"
#define kFetchAppID @"loadAppId"
#define kConfigActive @"setupActive"
#define kFetchActive @"loadActive"
#define k1ConfigAccessToken @"setUpAccessToken"
#define k1FetchAccessToken @"loadAccessToken"
#define k1ConfigRetryCount @"setUpRetryCount"
#define k1FetchRetryCount @"loadRetryCount"
#define k1ConfigIsRefresh @"setupRefresh"
#define k1FetchRefresh @"loadRefresh"

@implementation CTMediator (Config)

- (void)configIsRefreshing:(BOOL)isRefresh{
      [self performTarget:kTargetName action:k1ConfigIsRefresh params:@{@"isRefresh":@(isRefresh)} shouldCacheTarget:NO];
}
- (BOOL)fetchIsRefresh{
    return [[self performTarget:kTargetName action:k1FetchRefresh params:nil shouldCacheTarget:NO] boolValue];
}

- (void)configRetryCount:(NSInteger)count{
       [self performTarget:kTargetName action:k1ConfigRetryCount params:@{@"retryCount":@(count)} shouldCacheTarget:NO];
}
- (NSInteger)fetchRetryCount{
    return [[self performTarget:kTargetName action:k1FetchRetryCount params:nil shouldCacheTarget:NO] integerValue];
}

- (void)configAppID:(NSString *)appID{
     [self performTarget:kTargetName action:kConfigAppID params:@{@"appID":appID} shouldCacheTarget:NO];
}
- (NSString *)fetchAPPID{
    return [self performTarget:kTargetName action:kFetchAppID params:nil shouldCacheTarget:NO];
}

- (void)configIsActive:(BOOL)isActive{
     [self performTarget:kTargetName action:kConfigActive params:@{@"isActive":@(isActive)} shouldCacheTarget:NO];
}
- (BOOL)fetchIsActive{
      return [[self performTarget:kTargetName action:kFetchActive params:nil shouldCacheTarget:NO] boolValue];
}

- (void)configAccessToken:(NSString *)accessToken{
     [self performTarget:kTargetName action:k1ConfigAccessToken params:@{@"accessToken":accessToken} shouldCacheTarget:NO];
}
- (NSString *)fetchAccessToken{
     return [self performTarget:kTargetName action:k1FetchAccessToken params:nil shouldCacheTarget:NO];
}


- (void)configAuthCode:(NSString *)authCode{
    [self performTarget:kTargetName action:kConfigAuthCode params:@{@"authCode":authCode} shouldCacheTarget:NO];
}
- (NSString *)fetchAuthCode{
    return [self performTarget:kTargetName action:kFetchAuthCode params:nil shouldCacheTarget:NO];
}

- (void)configQQText:(NSString *)qqText{
    [self performTarget:kTargetName action:kConfigQQText params:@{@"qq":qqText} shouldCacheTarget:NO];
}

- (NSString *)fetchQQText{
     return [self performTarget:kTargetName action:kFetchQQText params:nil shouldCacheTarget:NO];
}

- (void)configEmail:(NSString *)email{
      [self performTarget:kTargetName action:kConfigEmail params:@{@"email":email} shouldCacheTarget:NO];
}
- (NSString *)fetchEmailText{
      return [self performTarget:kTargetName action:kFetchEmail params:nil shouldCacheTarget:NO];
}

- (void)configLogin:(BOOL)isLogin{
      [self performTarget:kTargetName action:kConfigLogin params:@{@"isLogin":@(isLogin)} shouldCacheTarget:NO];
}
- (BOOL)fetchIsLogin{
    return [[self performTarget:kTargetName action:kFetchLogin params:nil shouldCacheTarget:NO] boolValue];
}

- (void)configAppKey:(NSString *)appKey{
      [self performTarget:kTargetName action:kConfigAppKey params:@{@"appKey":appKey} shouldCacheTarget:NO];
}
- (NSString *)fetchAppKey{
      return [self performTarget:kTargetName action:kFetchAppKey params:nil shouldCacheTarget:NO];
}

@end
