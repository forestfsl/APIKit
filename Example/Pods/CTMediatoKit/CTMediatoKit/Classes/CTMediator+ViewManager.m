//
//  CTMediator+ViewManager.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/18.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "CTMediator+ViewManager.h"

@implementation CTMediator (ViewManager)

- (void)displayMainViewScene:(NSDictionary *)parameter{
    [self performTarget:@"SegmentViewHandler" action:@"mainView" params:parameter shouldCacheTarget:NO];
}

- (void)displayBindPhoneViewScene:(NSDictionary *)parameter{
    [self performTarget:@"SegmentViewHandler" action:@"bindPhoneView" params:parameter shouldCacheTarget:NO];
}

@end
