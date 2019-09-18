//
//  CTMediator+AppStore.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/18.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (AppStore)


- (void)requestToAppStore:(NSDictionary *)parameter;

- (void)resendFailureOrderForAppSotre:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
