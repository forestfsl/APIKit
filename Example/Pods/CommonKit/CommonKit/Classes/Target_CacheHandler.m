//
//  Target_CacheHandler.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "Target_CacheHandler.h"

#define k1AuthCode @"quthCode"
#define k1AppKey @"appKey"
#define k1QQText @"qqText"
#define k1Email @"email"
#define k1AccessToken @"accessToken"
#define k1IsLogin @"isLoign"
#define k1AppID @"appID"
#define k1IsActive @"active"
#define k1RetryCount @"retryCount"
#define k1IsRefresh @"isRefresh"

@implementation Target_CacheHandler
@synthesize authCode = _authCode;
@synthesize appKey = _appKey;
@synthesize qqText = _qqText;
@synthesize email = _email;
@synthesize accessToken = _accessToken;
@synthesize isLogin = _isLogin;
@synthesize appID = _appID;
@synthesize isActive = _isActive;
@synthesize retryCount = _retryCount;
@synthesize isRefresh = _isRefresh;

+ (instancetype)sharedInstance{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (NSUserDefaults *)defaults {
    if (!_defaults){
        
        _defaults = [NSUserDefaults  standardUserDefaults];
    }
    return _defaults;
}

- (BOOL)isRefresh{
    if (!_isRefresh) {
        _isRefresh = [self.defaults boolForKey:k1IsRefresh];
    }
    return _isRefresh;
}
- (void)setIsRefresh:(BOOL)isRefresh{
    _isRefresh = isRefresh;
    [self.defaults setBool:isRefresh forKey:k1IsRefresh];
    [self.defaults synchronize];
}

- (NSInteger)retryCount{
    if (!_retryCount) {
        _retryCount = [self.defaults integerForKey:k1RetryCount];
    }
    return _retryCount;
}

- (void)setRetryCount:(NSInteger)retryCount{
    _retryCount = retryCount;
    [self.defaults setInteger:retryCount forKey:k1RetryCount];
    [self.defaults synchronize];
}

- (NSString *)appID{
    if (!_appID) {
        _appID = [self.defaults valueForKey:k1AppID];
    }
    return _appID;
}
- (void)setAppID:(NSString *)appID{
    _appID = appID;
    [self.defaults setValue:appID forKey:k1AppID];
    [self.defaults synchronize];
}

- (BOOL)isLogin{
    if (!_isLogin) {
        _isLogin = [self.defaults boolForKey:k1IsLogin];
    }
    return _isLogin;
}
- (void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;
    [self.defaults setBool:isLogin forKey:k1IsLogin];
    [self.defaults synchronize];
}

- (NSString *)accessToken{
    if (!_accessToken) {
        _accessToken = [self.defaults valueForKey:k1AccessToken];
    }
    return _accessToken;
}
- (void)setAccessToken:(NSString *)accessToken{
    _accessToken = accessToken;
    [self.defaults setValue:accessToken forKey:k1AccessToken];
    [self.defaults synchronize];
}

- (NSString *)email{
    if (!_email) {
        _email = [self.defaults valueForKey:k1Email];
    }
    return _email;
}
- (void)setEmail:(NSString *)email{
    _email = email;
    [self.defaults setValue:email forKey:k1Email];
    [self.defaults synchronize];
}

- (NSString *)qqText{
    if (!_qqText) {
        _qqText = [self.defaults valueForKey:k1QQText];
    }
    return _qqText;
}
- (void)setQqText:(NSString *)qqText{
    _qqText = qqText;
    [self.defaults setValue:qqText forKey:k1QQText];
    [self.defaults synchronize];
}

- (NSString *)authCode{
    if (!_authCode) {
        _authCode = [self.defaults valueForKey:k1AuthCode];
    }
    return _authCode;
}
- (void)setAuthCode:(NSString *)authCode{
    _authCode = authCode;
    [self.defaults setValue:authCode forKey:k1AuthCode];
    [self.defaults synchronize];
}

- (NSString *)appKey{
    if (!_appKey) {
        _appKey = [self.defaults valueForKey:k1AppKey];
    }
    return _appKey;
}
- (void)setAppKey:(NSString *)appKey{
    _appKey = appKey;
    [self.defaults setValue:appKey forKey:k1AppKey];
    [self.defaults synchronize];
}

- (void)setIsActive:(BOOL)isActive{
    _isActive = isActive;
    [self.defaults setBool:isActive forKey:k1IsActive];
    [self.defaults synchronize];
}
- (BOOL)isActive{
    if (!_isActive) {
        _isActive = [self.defaults boolForKey:k1IsActive];
    }
    return _isActive;
}

- (void)Action_setUpAuthCode:(NSDictionary *)parameter{
    NSString *authCode = parameter[@"authCode"];
    self.authCode = authCode;
}
- (NSString *)Action_loadAuthCode:(NSDictionary *)parameter{
    return self.authCode;
}

- (void)Action_setUpQQText:(NSDictionary *)parameter{
    NSString *qqText = parameter[@"qq"];
    self.qqText = qqText;
}
- (NSString *)Action_loadQQText:(NSDictionary *)parameter{
    return self.qqText;
}

- (void)Action_setUpEmail:(NSDictionary *)parameter{
    NSString *email = parameter[@"email"];
    self.email = email;
}
- (NSString *)Action_loadEmail:(NSDictionary *)parameter{
    return self.email;
}

- (void)Action_setUpLogin:(NSDictionary *)parameter{
    BOOL isLogin = [parameter[@"isLogin"] boolValue];
    self.isLogin = isLogin;
}
- (BOOL)Action_loadLogin:(NSDictionary *)parameter{
    return self.isLogin;
}

- (void)Action_setUpAppKey:(NSDictionary *)parameter{
    NSString *appKey = parameter[@"appKey"];
    self.appKey = appKey;
}
- (NSString *)Action_loadAppKey:(NSDictionary *)parameter{
    return self.appKey;
}

- (void)Action_setUpAppID:(NSDictionary *)parameter{
    NSString *appId = parameter[@"appID"];
    self.appID = appId;
}
- (NSString *)Action_loadAppId:(NSDictionary *)parameter{
    return self.appID;
}

- (void)Action_setupActive:(NSDictionary *)parameter{
    NSString *isActive = parameter[@"isActive"];
    self.isActive = [isActive boolValue];
}
- (BOOL)Action_loadActive:(NSDictionary *)parameter{
    return self.isActive;
}

- (void)Action_setUpAccessToken:(NSDictionary *)parameter{
    NSString *accessToken = parameter[@"accessToken"];
    self.accessToken = accessToken;
}
- (NSString *)Action_loadAccessToken:(NSDictionary *)paramete{
    return self.accessToken;
}

- (void)Action_setUpRetryCount:(NSDictionary *)parameter{
    NSString *retryCount = parameter[@"retryCount"];
    self.retryCount = [retryCount integerValue];
}
- (NSInteger )Action_loadRetryCount:(NSDictionary *)paramete{
    return self.retryCount;
}

- (void)Action_setupRefresh:(NSDictionary *)parameter{
    NSString *isRefresh = parameter[@"isRefresh"];
    self.isRefresh = [isRefresh boolValue];
}
- (BOOL )Action_loadRefresh:(NSDictionary *)paramete{
    return self.isRefresh;
}
@end
