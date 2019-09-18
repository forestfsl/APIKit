//
//  CTMediator+AppStore.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/18.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "CTMediator+AppStore.h"

@implementation CTMediator (AppStore)

- (void)requestToAppStore:(NSDictionary *)parameter{
    [[CTMediator sharedInstance] performTarget:@"PurchaseManager" action:@"createOrderToPurchase" params:parameter shouldCacheTarget:NO];
}

- (void)resendFailureOrderForAppSotre:(NSDictionary *)parameter{
     [[CTMediator sharedInstance] performTarget:@"PurchaseManager" action:@"resendFailureOrderToAppStore" params:parameter shouldCacheTarget:NO];
}

@end
