//
//  Target_PurchaseManager.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/18.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_PurchaseManager : NSObject

- (void)Action_createOrderToPurchase:(NSDictionary *)parameter;
- (void)Action_resendFailureOrderToAppStore:(NSDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END
