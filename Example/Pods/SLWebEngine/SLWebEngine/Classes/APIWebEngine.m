//
//  APIWebEngine.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/12.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "APIWebEngine.h"
#import "SystemDeviceSimulateIDFA.h"
#import "APIAFNetworking.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "sys/utsname.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import<SystemConfiguration/CaptiveNetwork.h>
#import "SystemDeviceSimulateIDFA.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <zlib.h>
#import <dlfcn.h>
#import <CommonCrypto/CommonDigest.h>
#import <CTMediatoKit/CTMediator+Config.h>


// 上传日志的LogUrl
#define kLogUrl [self fetchURLWords:@"13"]
// 激活接口
#define kActiveUrl  [self fetchURLWords:@"1"]
// 快速注册
#define kFastRegisterUrl [self fetchURLWords:@"2"]
// 注册
#define kRegisterUrl [self fetchURLWords:@"3"]
// 登录
#define kSigninUrl [self fetchURLWords:@"4"]
// 获取用户信息
#define kGetUserInfoUrl [self fetchURLWords:@"11"]
// 忘记密码
#define kForgetPwdUrl [self fetchURLWords:@"5"]
// 获取忘记密码验证码
#define kGetForgetPwdCodeUrl [self fetchURLWords:@"6"]
// 绑定手机
#define kBindTelUrl [self fetchURLWords:@"7"]
// 获取绑定手机验证码
#define kGetBindTelCodeUrl [self fetchURLWords:@"8"]
// 创建订单
#define kCreateOrderUrl [self fetchURLWords:@"9"]
// 上传票据
#define kUploadTransactionUrl [self fetchURLWords:@"10"]
// 用户协议
#define kUserProtocolUrl [self fetchURLWords:@"14"]
// 隐私协议
#define kPrivacyProtocolUrl [self fetchURLWords:@"15"]

// 参数
#define kParameterMap @{@"username":@"1", @"password":@"2", @"authorize_code":@"3", @"access_token":@"4", @"id":@"5", @"bind_tel":@"6", @"msg":@"7", @"phone":@"8", @"code":@"9", @"type":@"10", @"count":@"11", @"sid":@"12", @"rid":@"13", @"role":@"14", @"pid":@"15", @"extend":@"16", @"cid":@"17", @"data":@"18", @"receipt":@"19", @"name":@"20", @"x":@"21", @"y":@"22", @"time":@"23", @"qq":@"24", @"tel":@"25", @"email":@"26", @"stamp":@"27",@"fork":@"28",@"public":@"29",@"wwdc":@"30",@"request":@"31"}


#define kDomainName @"https://app.michub.online"

@implementation APIWebEngine

- (NSString *)fetchURLWords:(NSString *)urlWord{
    NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];
    NSArray *consts = @[@"b", @"c", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"m", @"n", @"p", @"qu", @"r", @"s", @"t", @"v", @"w", @"x", @"y", @"z", @"tt", @"ch", @"sh"];
    int len = arc4random() % 20+2;// length between 1-20
    NSString *word = @"";
    BOOL is_vowel = FALSE;
    NSArray *arr;
    
    for (int i = 0; i < len; i++) {
        if (is_vowel) {
            arr = vowels;
        } else {
            arr = consts;
        }
        is_vowel = !is_vowel;
        
        word = [NSString stringWithFormat:@"%@%@", word, arr[arc4random() % arr.count]];
    }
    return [NSString stringWithFormat:@"%@%@", word, urlWord];
}

+ (instancetype)sharedStoryAPIBoard{
    static APIWebEngine *APIBoard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        APIBoard = [[self alloc]init];
    });
    return APIBoard;
}

- (NSString *)engineA_fetchLetterForWebWithStoryNumber:(int)story_number{
    NSArray *letterArray = @[@"a",@"b",@"c",@"d"];
    return letterArray[story_number-1];
}

- (void)engineA_RequestForWebActivateWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kActiveUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebTouristWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kFastRegisterUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebRegisterWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kRegisterUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebLoginWithStoryarams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kSigninUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebGetUserInfoWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kGetUserInfoUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebForgetPwdWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kForgetPwdUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebGetForgetPwdCodeWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kGetForgetPwdCodeUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebBindTelWithParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kBindTelUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebGetBindTelCodeWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kGetBindTelCodeUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebCreateOrderWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kCreateOrderUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebUploadPmtVoucherWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kUploadTransactionUrl story_success:story_success story_fail:story_fail];
}


- (void)engineA_RequestForWebuploadStoryparams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail{
    [self engineA_requestForWebWithStoryParams:story_param engineA_baseUrl:kDomainName engineA_method:kLogUrl story_success:story_success story_fail:story_fail];
}


#pragma mark - 请求
- (void)engineA_requestForWebWithStoryParams:(NSDictionary *)story_params
                             engineA_baseUrl:(NSString *)engine_urlString
                              engineA_method:(NSString *)story_method
                               story_success:(StorySuccess)story_success
                                  story_fail:(StoryFail)story_fail
{
    if (!(engine_urlString.length > 0)) {
        return;
    }
    [self engineA_requestWithStoryBody_story_Params:story_params engineA_requestStoryBaseUrl:engine_urlString engineA_requestStoryMethod:story_method engineA_complete:^(BOOL isSuccess, NSDictionary *dict) {
        if (isSuccess && [dict isKindOfClass:[NSDictionary class]]) {
            
            NSInteger ret = [[dict objectForKey:@"ret"] integerValue];
            if (dict && ret == 1) {
                NSDictionary *data = [dict objectForKey:@"data"];
                if (story_success) {
                    story_success(data);
                }
                
            }else{
                if (story_fail) {
                    story_fail(dict);
                }
                
            }
        }else{
            if (story_fail) {
                story_fail(dict);
            }
        }
    }];

}

- (void)engienA_requestForWebUploadPmtVoucherWithParams:(NSDictionary *)story_params
                                        engineA_baseUrl:(NSString *)engineA_urlString
                                         engineA_method:(NSString *)story_method
                                          story_success:(StorySuccess)story_success
                                             story_fail:(StoryFail)story_fail {
    
    [self engineA_requestWithStoryBody_story_Params:story_params engineA_requestStoryBaseUrl:engineA_urlString engineA_requestStoryMethod:story_method engineA_complete:^(BOOL isSuccess, NSDictionary *dict) {
        
        if (isSuccess && [dict isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = [dict objectForKey:@"data"];
            if (story_success) {
                story_success(data);
            }
        }else{
            if (story_fail) {
                story_fail(dict);
            }
        }
    }];
}

-(void)engineA_requestWithStoryBody_story_Params:(NSDictionary *)params
                     engineA_requestStoryBaseUrl:(NSString *)baseUrl
                      engineA_requestStoryMethod:(NSString *)requestMethod
                                engineA_complete:(StoryResponseComplete_StoryBlock)engineA_complete{
    // 拼接请求Url地址
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", baseUrl, requestMethod];
    
    APIAFURLSessionManager *manager = [[APIAFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    StoryAFHTTPResponseSerializer *responseSerializer = [StoryAFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    
    NSMutableURLRequest *request = [[StoryAFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 20;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [request setValue:[self spliceHeader] forHTTPHeaderField:@"device"];
    [request setHTTPBody:[[self spliceBody:params] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSInteger statusCode = httpResponse.statusCode;
        if (statusCode == 200) {
            NSLog(@"\n********************************* 请求成功 *********************************");
            NSLog(@"\n[网络请求][Response] : %@\n[网路请求][RequestURL ] : %@\n[网路请求][StatusCode ] : %ld",response,httpResponse.URL,(long)httpResponse.statusCode);
            
            if (!error && responseObject && [responseObject isKindOfClass:[NSData class]]) {
                
                NSData *base64Data = [self segmentBaseSixFourDecodedWithData:responseObject];
                
                
                NSData *xorData = [self segmentXORDecryptWithAppKey:[[CTMediator sharedInstance] fetchAppKey] data:base64Data];
                NSString *decodedString = [[NSString alloc] initWithData:xorData encoding:NSUTF8StringEncoding];
                
                
                NSDictionary *dict = [self dictWithJson:decodedString];
                NSLog(@"\n[网络请求][ResponseObj] : %@",dict.description);
                engineA_complete(YES,dict);
            }else{
                NSLog(@"\n[网络请求][ResponseObj] : %@",responseObject);
                engineA_complete(NO,responseObject);
            }
        }else{
            NSLog(@"\n[网络请求][Response] : %@\n[网路请求][RequestURL] : %@\n[网路请求][StatusCode] : %ld\n[网络请求][Error] : %@",response,httpResponse.URL,(long)httpResponse.statusCode,error);
            engineA_complete(NO,@{@"msg":error.localizedDescription});
        }
    }] resume];
}

#pragma mark - Private Method

- (NSString *)spliceHeader {
    
    //迟点再考虑用什么方法去获取这个appid的值
    NSString *appid = [self fetchAppID];
    NSString *idfa  = [self fetchIDFA];
    NSString *appVersionCode = [self fetchAppVersionCode];
    NSString *sdkVersionCode = [self fetchSDKVersion];
    NSString *sysVersion = [self fetchSysVersion];
    NSString *model = [self fetchPhoneModel];
    NSString *bundelId = [self fetchBundleID];
    NSString *wifiName = [self fetchNetworkName];
    NSString *deviceInfo = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@ %@",appid,idfa,appVersionCode,sdkVersionCode,sysVersion,model,bundelId,wifiName];
    NSParameterAssert(appid);
    NSParameterAssert(idfa);
    NSParameterAssert(appVersionCode);
     NSParameterAssert(sdkVersionCode);
     NSParameterAssert(sysVersion);
     NSParameterAssert(model);
     NSParameterAssert(bundelId);
     NSParameterAssert(wifiName);
    return deviceInfo;
}


- (NSString *)fetchAppID{
    self.gameAppId = [[CTMediator sharedInstance] fetchAPPID];
    return self.gameAppId;
}

- (NSString *)fetchNetworkName{
    if (!_deviceWifiName) {
        _deviceWifiName = @"iOS13 Can't not fetch wifi";
        CFArrayRef myArray = CNCopySupportedInterfaces();
        if (myArray != nil) {
            CFDictionaryRef myDict =CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                _deviceWifiName = [dict valueForKey:@"SSID"];
            }
        }
    }
    return _deviceWifiName;
}

- (NSString *)fetchBundleID{
    self.appBundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return self.appBundleID;
}

- (NSString *)fetchAppVersionCode {
    self.appVersion =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return self.appVersion;
}
- (NSString *)fetchSDKVersion{
    return @"2.0.0";
}

- (NSString *)fetchSysVersion{
    self.systemVersion = [[UIDevice currentDevice] systemVersion];
    return self.systemVersion;
}

- (NSString *)fetchPhoneModel{
    if (!_phoneModel) {
        NSString *deviceModel = [self fetchDeviceName];
        if (_phoneModel.length > 0) {
            _phoneModel = deviceModel;
        }else{
            _phoneModel = [[UIDevice currentDevice] model];
        }
    }
    return _phoneModel;
}

// 获取设备型号然后手动转化为对应名称
- (NSString *)fetchDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [deviceString stringByReplacingOccurrencesOfString:@"," withString:@"_"];
}


- (NSString *)spliceBody:(NSDictionary *)parames{
    NSString *result;
    
    NSData *data = [[self jsonStringWithDict:parames] dataUsingEncoding:NSUTF8StringEncoding];
    data = [self segmentBXOREncryptWithKey:[[CTMediator sharedInstance] fetchAppKey] data:data];
    result = [self segmentBaseSixFourEncode:data];
    
    return result;
}

#pragma mark - Other Tools
/// NSDictionary 转 NSString
- (NSString *)jsonStringWithDict:(NSDictionary *)dict{
    NSError *error;
    NSString *jsonString;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        
        NSLog(@"[NSDictionary转NSString][Error] : %@",error);
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

/// NSString 转 NSDictionary
- (NSDictionary *)dictWithJson:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (NSString *)fetchIDFA {
    float iosVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *deviceId = [[NSString alloc] init];
    
    if (iosVersion >= 7.0) {
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            // 获取idfa做为设备唯一标识
            deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        }else{
            deviceId = [SystemDeviceSimulateIDFA createSimulateIDFA];
        }
        
    } else {
        deviceId = [self fetchMacAddress];
    }
    return deviceId;
}

- (NSString *)fetchMacAddress {
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
    
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    free(msgBuffer);
    return macAddressString;
}

- (NSString *)segmentBaseSixFourEncode:(NSData *)data{
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSData *)segmentBXOREncryptWithKey:(NSString *)appKey data:(NSData *)data
{
    
    NSString const *privateKey = appKey;
    
    
    NSInteger length = privateKey.length;
    
    
    const char *keys = [privateKey cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cKey[length];
    
    memcpy(cKey, keys, length);
    
    
    NSMutableData *encryptData = [[NSMutableData alloc] initWithCapacity:length];
    
    
    const Byte *point = data.bytes;
    
    for (int i = 0; i < data.length; i++) {
        int l = i % length;
        char c = cKey[l];
        Byte b = (Byte) ((point[i]) ^ c);
        [encryptData appendBytes:&b length:1];
    }
    
    return encryptData.copy;
}


- (NSData *)segmentBaseSixFourDecodedWithData:(NSData *)data {
    
    
    return [[NSData alloc] initWithBase64EncodedData:data options:0];
}

- (NSData *)segmentXORDecryptWithAppKey:(NSString *)appKey data:(NSData *)data
{
    
    return [self segmentBXOREncryptWithKey:appKey data:data];
}


@end
