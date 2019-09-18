//
//  CTMediator+SegmentViewHud.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "CTMediator+SegmentViewHud.h"


@implementation CTMediator (SegmentViewHud)

-(id)segmentViewDisplayError:(NSString *)errorMessage{
    return [self performTarget:@"HUDViewHandler" action:@"displayError" params:
    @{@"error":errorMessage} shouldCacheTarget:NO];
}

-(id)segmentViewAddTo:(id)target animated:(BOOL)animated{
    return [self performTarget:@"HUDViewHandler" action:@"addViewTo" params:@{@"target":target,@"animated":@(animated)} shouldCacheTarget:NO];
}

-(id)segmentViewHiddenFrom:(id)target animated:(BOOL)animated{
     return [self performTarget:@"HUDViewHandler" action:@"hideViewFrom" params:@{@"target":target,@"animated":@(animated)} shouldCacheTarget:NO];
}
-(id)segmentViewDisplaySuccess:(NSString *)successMessage{
    return [self performTarget:@"HUDViewHandler" action:@"displaySuccess" params:
            @{@"success":successMessage} shouldCacheTarget:NO];
}

-(id)segmentViewHide{
    return [self performTarget:@"HUDViewHandler" action:@"hideView" params:
            @{} shouldCacheTarget:NO];
}
@end
