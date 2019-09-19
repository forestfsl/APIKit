//
//  Target_HUDViewHandler.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_HUDViewHandler : NSObject

- (id)Action_displayError:(NSDictionary *)parameter;
- (id)Action_addViewTo:(NSDictionary *)parameter;
- (id)Action_hideViewFrom:(NSDictionary *)parameter;
- (id)Action_displaySuccess:(NSDictionary *)parameter;
- (id)Action_hideView:(NSDictionary *)paremeter;

@end

NS_ASSUME_NONNULL_END
