//
//  CTMediator+RequestAPI.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <CTMediator/CTMediator.h>
#import "CTMediaAFNetworkReachbilityManager.h"

typedef enum : NSUInteger {
    ActivateRequest,
    TouristRequest,
    RegisterRequest,
    LoginRequest,
    UserInfoRequest,
    ForgetPasswordRequest,
    ForgetPasswordCodeRequest,
    BindPhoneRequest,
    BindPhoneCodeReuqest,
    CreateOrderRequest,
    UploadTransactionRequest
} RequestType;




typedef void(^RequestSuccessAPIBlock)(NSDictionary * _Nullable data);
typedef void(^RequestFailAPIBlock)(NSDictionary * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (RequestAPI)

- (id)request:(NSDictionary *)param type:(RequestType)type success:(RequestSuccessAPIBlock)success fail:(RequestFailAPIBlock)fail;

//- (void)startMonitorStatus:(void (^)(CTMediaAFNetworkReachabilityStatus status))block;
//- (void)stopMonitorStatus;


@end

NS_ASSUME_NONNULL_END
