//
//  Target_HUDViewHandler.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "Target_HUDViewHandler.h"
#import "APIProgressHUD+Board.h"

@implementation Target_HUDViewHandler

- (id)Action_displayError:(NSDictionary *)parameter{
     [APIProgressHUD showError:parameter[@"error"]];
    return nil;
}
- (id)Action_addViewTo:(NSDictionary *)parameter{
    [APIProgressHUD showHUDAddedTo:parameter[@"target"] animated:[parameter[@"animated"] boolValue]];
    return nil;
}
- (id)Action_hideViewFrom:(NSDictionary *)parameter{
    [APIProgressHUD hideHUDForView:parameter[@"target"] animated:[parameter[@"animated"] boolValue]];
    return nil;
}

- (id)Action_displaySuccess:(NSDictionary *)parameter{
        [APIProgressHUD showSuccess:parameter[@"success"]];
    return nil;
}
- (id)Action_hideView:(NSDictionary *)paremeter{
    [APIProgressHUD hideHUD];
    return nil;
}

@end
