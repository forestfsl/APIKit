//
//  Target_APIRequestHandler.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "Target_APIRequestHandler.h"
#import "APIWebEngine.h"

@implementation Target_APIRequestHandler

- (id)Action_requestForgetPasswordCode:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebGetForgetPwdCodeWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
    return nil;
}

- (id)Action_requestActive:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebActivateWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestTourist:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebTouristWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestRegister:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebRegisterWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestLogin:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebLoginWithStoryarams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestUserInfo:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebGetUserInfoWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestForgetPassword:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebForgetPwdWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestBindPhoneCode:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebGetBindTelCodeWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestBindPhone:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebBindTelWithParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestCreateOrder:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebCreateOrderWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}
- (id)Action_requestTransaction:(NSDictionary *)parameter{
    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebUploadPmtVoucherWithStoryParams:parameter[@"data"] story_success:parameter[@"successBlock"] story_fail:parameter[@"failBlock"]];
      return nil;
}

@end
