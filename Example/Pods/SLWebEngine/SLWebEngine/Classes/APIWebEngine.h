//
//  APIWebEngine.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/12.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^StorySuccess)(NSDictionary * _Nullable data);
typedef void (^StoryFail)(NSDictionary * _Nullable error);
typedef void (^StoryResponseComplete_StoryBlock)(BOOL isSuccess, NSDictionary * _Nullable  dict);

NS_ASSUME_NONNULL_BEGIN

@interface APIWebEngine : NSObject

@property (nonatomic, copy) NSString *gameAppId;
@property (nonatomic, copy) NSString *deviceIDFA;
@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *sdkVersion;
@property (nonatomic, copy) NSString *systemVersion;
@property (nonatomic, copy) NSString *phoneModel;
@property (nonatomic, copy) NSString *appBundleID;
@property (nonatomic, copy) NSString *deviceWifiName;


+ (instancetype)sharedStoryAPIBoard;

- (void)engineA_RequestForWebActivateWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebTouristWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebRegisterWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebLoginWithStoryarams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebGetUserInfoWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebForgetPwdWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebGetForgetPwdCodeWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebBindTelWithParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebGetBindTelCodeWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebCreateOrderWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebUploadPmtVoucherWithStoryParams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;


- (void)engineA_RequestForWebuploadStoryparams:(NSDictionary *)story_param story_success:(StorySuccess)story_success story_fail:(StoryFail)story_fail;

- (NSString *)engineA_fetchLetterForWebWithStoryNumber:(int)story_number;

-(void)engineA_requestWithStoryBody_story_Params:(NSDictionary *)params
                     engineA_requestStoryBaseUrl:(NSString *)baseUrl
                      engineA_requestStoryMethod:(NSString *)requestMethod
                                engineA_complete:(StoryResponseComplete_StoryBlock)engineA_complete;

@end

NS_ASSUME_NONNULL_END
