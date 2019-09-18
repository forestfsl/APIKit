//
//  Target_APIRequestHandler.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_APIRequestHandler : NSObject


- (id)Action_requestForgetPasswordCode:(NSDictionary *)parameter;
- (id)Action_requestActive:(NSDictionary *)parameter;
- (id)Action_requestTourist:(NSDictionary *)parameter;
- (id)Action_requestRegister:(NSDictionary *)parameter;
- (id)Action_requestLogin:(NSDictionary *)parameter;
- (id)Action_requestUserInfo:(NSDictionary *)parameter;
- (id)Action_requestForgetPassword:(NSDictionary *)parameter;
- (id)Action_requestBindPhoneCode:(NSDictionary *)parameter;
- (id)Action_requestBindPhone:(NSDictionary *)parameter;
- (id)Action_requestCreateOrder:(NSDictionary *)parameter;
- (id)Action_requestTransaction:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
