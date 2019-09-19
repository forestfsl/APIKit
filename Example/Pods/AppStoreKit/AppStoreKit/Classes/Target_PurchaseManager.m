//
//  Target_PurchaseManager.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/18.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "Target_PurchaseManager.h"
#import "APIProgressHUD+Board.h"
#import "APIHeader.h"
#import "CategoryHeader.h"
#import "SegmentAppStoreManager.h"


#define k2ParameterMap @{@"username":@"1", @"password":@"2", @"authorize_code":@"3", @"access_token":@"4", @"id":@"5", @"bind_tel":@"6", @"msg":@"7", @"phone":@"8", @"code":@"9", @"type":@"10", @"count":@"11", @"sid":@"12", @"rid":@"13", @"role":@"14", @"pid":@"15", @"extend":@"16", @"cid":@"17", @"data":@"18", @"receipt":@"19", @"name":@"20", @"x":@"21", @"y":@"22", @"time":@"23", @"qq":@"24", @"tel":@"25", @"email":@"26", @"stamp":@"27",@"fork":@"28",@"public":@"29",@"wwdc":@"30",@"request":@"31"}

@implementation Target_PurchaseManager

- (void)Action_createOrderToPurchase:(NSDictionary *)parameter{
    
    NSDictionary *receiveParameter = parameter[@"data"];
    NSMutableDictionary *sendParameter = [[NSMutableDictionary alloc] initWithDictionary:@{[k2ParameterMap[@"count"] fetchURLWords]:receiveParameter[@"count"],[k2ParameterMap[@"extend"] fetchURLWords]:receiveParameter[@"extend"],[k2ParameterMap[@"id"] fetchURLWords]:receiveParameter[@"id"],[k2ParameterMap[@"pid"] fetchURLWords]:receiveParameter[@"pid"],[k2ParameterMap[@"rid"] fetchURLWords]:receiveParameter[@"rid"],[k2ParameterMap[@"role"] fetchURLWords]:receiveParameter[@"role"],[k2ParameterMap[@"sid"] fetchURLWords]:receiveParameter[@"sid"],[k2ParameterMap[@"access_token"] fetchURLWords]:receiveParameter[@"access_token"]}];
   
    NSLog(@"请求参数:%@",sendParameter);
    [APIProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];

    [[APIWebEngine sharedStoryAPIBoard] engineA_RequestForWebCreateOrderWithStoryParams:sendParameter story_success:^(NSDictionary * _Nullable data) {
        [APIProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        [APIProgressHUD hideHUD];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:[sendParameter segment_FetchContentString:k2ParameterMap[@"pid"]] forKey:@"pid"];
        NSString *orderMap = [data segment_FetchContentString:k2ParameterMap[@"order_no"]];
        NSString *orderNumber = data[@"order_no"];
        if (orderMap.length > 0) {
            [params setValue:[data segment_FetchContentString:k2ParameterMap[@"order_no"]] forKey:@"cid"];
        }else if(orderNumber.length > 0){
            [params setValue:data[@"order_no"] forKey:@"cid"];
        }
        [[SegmentAppStoreManager sharedPurChaseManager] board_purchaseProducts:params];
        
    } story_fail:^(NSDictionary * _Nullable error) {
        [APIProgressHUD showError:error[@"msg"]];
         [APIProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        [APIProgressHUD hideHUD];
        
    }];
  
    
}


- (void)Action_resendFailureOrderToAppStore:(NSDictionary *)parameter{
      [SegmentAppStoreManager sharedPurChaseManager];
}
@end
