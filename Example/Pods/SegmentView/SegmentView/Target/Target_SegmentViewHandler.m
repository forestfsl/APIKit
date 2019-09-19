//
//  SegmentViewHandler.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/18.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "Target_SegmentViewHandler.h"
#import "SegmentMainView.h"
#import "SegmentBindPhoneView.h"

@implementation Target_SegmentViewHandler

- (void)Action_mainView:(NSDictionary *)parameter{
     [[SegmentMainView segment_createMainView] segment_displayMainView];
}

- (void)Action_bindPhoneView:(NSDictionary *)parameter{
    //changeContent1
    SegmentBindPhoneView *bindPhoneView = [[SegmentBindPhoneView alloc]init];
    [ChirsKeyWindow addSubview:bindPhoneView];
    [bindPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}
@end
