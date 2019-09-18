#import "StorySDKAPI.h"
#import "CTMediatorHeader.h"
#import "IQKeyboardManager.h"
#import "APIHeader.h"
#import "CategoryHeader.h"




NSString *const kActivateForNotification    = @"ActivateNotification";
NSString *const krequestLoginForNotification  = @"requestLoginNotification";
NSString *const kLoginCheckForNotification  = @"LoginCheckNotification";
NSString *const kLogoutForNotification      = @"LogoutNotification";
NSString *const kPurchaseForNotification    = @"PurchaseNotification";


NSString *const kuserID         = @"user_id";
NSString *const kusername       = @"user_name";
NSString *const ktoken      = @"access_token";


NSString *const kCpOrderId   = @"id";
NSString *const kGoodsId     = @"pid";
NSString *const kGoodsPrice  = @"count";
NSString *const kServerId    = @"sid";
NSString *const kRoleId      = @"rid";
NSString *const kRoleName    = @"role";
NSString *const kExtend      = @"extend";

#define k3ParameterMap @{@"username":@"1", @"password":@"2", @"authorize_code":@"3", @"access_token":@"4", @"id":@"5", @"bind_tel":@"6", @"msg":@"7", @"phone":@"8", @"code":@"9", @"type":@"10", @"count":@"11", @"sid":@"12", @"rid":@"13", @"role":@"14", @"pid":@"15", @"extend":@"16", @"cid":@"17", @"data":@"18", @"receipt":@"19", @"name":@"20", @"x":@"21", @"y":@"22", @"time":@"23", @"qq":@"24", @"tel":@"25", @"email":@"26", @"stamp":@"27",@"fork":@"28",@"public":@"29",@"wwdc":@"30",@"request":@"31"}

#define k4ReplaceNil(value, defaultValue) (!k2isStringEmpty(value) ? value : defaultValue)

#define k2isStringEmpty(str) ((str) == nil || [(str) isKindOfClass:[NSNull class]] || [(str) isEqual:@""])


@implementation StorySDKAPI


+ (instancetype)board_sharedAPI_storyInstance{
    static StorySDKAPI *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

+ (void)activeWithAppID:(NSString *)appID
                          unique_appKey:(NSString *)appKey{
    [[CTMediator sharedInstance] configIsActive:NO];
    if (k2isStringEmpty(appID) || k2isStringEmpty(appKey)) {
        [[CTMediator sharedInstance] segmentViewDisplayError:@"AppId 或者 AppKey 不能为空!"];
      
        return;
    }
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[CTMediator sharedInstance] configAppID:appID];
    [[CTMediator sharedInstance] configAppKey:appKey];
    [[CTMediator sharedInstance] configRetryCount:1];
    [self reachabilityStartMonitoringAndRequestInitData];
}


+ (void)reachabilityStartMonitoringAndRequestInitData {
    [[CTMediaAFNetworkReachbilityManager sharedManager] startMonitoring];
    
    [[CTMediaAFNetworkReachbilityManager sharedManager] setReachabilityStatusChangeBlock:^(CTMediaAFNetworkReachabilityStatus status) {
        switch (status) {
            case CTMediaAFNetworkReachabilityStatusNotReachable:
                [[CTMediator sharedInstance] segmentViewDisplayError:@"请检查当前网络状态"];
                break;
            case CTMediaAFNetworkReachabilityStatusUnknown:
                 [[CTMediator sharedInstance] segmentViewDisplayError:@"当前网络不可用"];
                break;
            default:
                [[CTMediator sharedInstance] configIsRefreshing:YES];
                [self board_retryActive_ForPlatformBoard:NO];
                break;
        }
    }];
}

+ (void)board_retryActive_ForPlatformBoard:(BOOL)isFromLogin{
    if (!isFromLogin) {
        if ([[CTMediator sharedInstance] fetchRetryCount] > 10) {
            [[CTMediaAFNetworkReachbilityManager sharedManager] stopMonitoring];
            [[CTMediator sharedInstance] configIsRefreshing:NO];
            [[CTMediator sharedInstance] configRetryCount:1];
           
            return;
        }
    }else{
        if ([[CTMediator sharedInstance] fetchRetryCount] > 10) {
            [[CTMediator sharedInstance] segmentViewDisplayError:@"你的网络好像有点问题，请重试"];
            return;
        }
    }
    [[CTMediator sharedInstance] request:@{} type:ActivateRequest success:^(NSDictionary * _Nullable data) {
        [[CTMediator sharedInstance] configIsActive:YES];
        
      [[CTMediator sharedInstance] configEmail: [data segment_FetchContentString:k3ParameterMap[@"email"]]];
        [[CTMediator sharedInstance] configQQText:[data segment_FetchContentString:k3ParameterMap[@"qq"]]];

        NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
        [mDict setObject:[NSNumber numberWithInt:1] forKey:@"result"];
        [mDict setObject:@"激活成功!" forKey:@"msg"];
        //changeContent1
        [[NSNotificationCenter defaultCenter] postNotificationName:kActivateForNotification object:nil userInfo:mDict];
        [[CTMediator sharedInstance] configRetryCount:1];
    
        if (isFromLogin) {
            [[CTMediator sharedInstance] displayMainViewScene:@{}];
           
        }
            
            //changeContent1
    } fail:^(NSDictionary * _Nullable error) {
       NSInteger retryCount = [[CTMediator sharedInstance] fetchRetryCount];
        retryCount++;
        [[CTMediator sharedInstance] configRetryCount:retryCount];
        [[CTMediator sharedInstance] configIsActive:NO];
      
        NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
        [mDict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
        [mDict setObject:@"激活失败!" forKey:@"msg"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kActivateForNotification object:nil userInfo:mDict];
        [self board_retryActive_ForPlatformBoard:isFromLogin];
    }];
}



+ (void)requestLogin{
  
    BOOL active = [[CTMediator sharedInstance] fetchIsActive];
    BOOL isRefresh = [[CTMediator sharedInstance] fetchIsRefresh];
      //changeContent1
    if (!active && !isRefresh) {
        [self board_retryActive_ForPlatformBoard:YES];
        [[CTMediator sharedInstance] configIsRefreshing:YES];
       
    }else if (active){
       [[CTMediator sharedInstance] displayMainViewScene:@{}];
    }else{
        [[CTMediator sharedInstance] segmentViewDisplaySuccess:@"正在初始化，请稍等"];
        return;
    }
    
    
    
}



+ (void)requestAuthUserInfo:(NSDictionary *)userInfo{
    [[CTMediator sharedInstance] configAccessToken:userInfo[@"access_token"]];

     __weak __typeof(&*self)weakSelf = self;
     NSDictionary *param = @{ktoken : k4ReplaceNil([[CTMediator sharedInstance] fetchAccessToken], @"")};
    [[CTMediator sharedInstance] request:param type:UserInfoRequest success:^(NSDictionary * _Nullable data) {
        [[CTMediator sharedInstance] resendFailureOrderForAppSotre:@{}];
      
        BOOL isBindPhone = [[data segment_FetchContentString:k3ParameterMap[@"bind_tel"]] boolValue];
     
        if (!isBindPhone) {
            [weakSelf cherry_showBindPhoneView];
        }
    } fail:^(NSDictionary * _Nullable error) {
         NSString *errorMessage = error[@"msg"];
        [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
    }];
    
}





+ (void)cherry_showBindPhoneView{
    [[CTMediator sharedInstance] displayBindPhoneViewScene:@{}];
    
}


+ (void)requestLogout{
    [[CTMediator sharedInstance] configAccessToken:@""];
    [[CTMediator sharedInstance] configAuthCode:@""];
    [[CTMediator sharedInstance] configLogin:NO];
     //changeContent1
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
    [mDict setObject:[NSNumber numberWithInt:1] forKey:@"result"];
    [mDict setObject:@"注销成功" forKey:@"msg"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutForNotification object:nil userInfo:mDict];
    
}


+ (void)sendPurchaseRequest:(NSDictionary *)params{
    BOOL isLogin = [[CTMediator sharedInstance] fetchIsLogin];
    if (!isLogin) {
        [[CTMediator sharedInstance] segmentViewDisplayError:@"请检查您的网络"];
        
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
     [dict setValue:[[CTMediator sharedInstance] fetchAccessToken] ? [[CTMediator sharedInstance] fetchAccessToken]: @"" forKey:ktoken];
   
    [[CTMediator sharedInstance] requestToAppStore:@{@"data":dict}];
  
}



+ (NSDictionary *)requestVersionInfo{
     return  @{@"SDKVersion":@"2.0.0"};
}




@end
