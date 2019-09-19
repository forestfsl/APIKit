//
//  SegmentForgetPasswordView.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "BaseSegmentView.h"

typedef void(^SegmentForgetPasswordBlock)(BOOL isBack, NSDictionary * _Nullable parameter);



NS_ASSUME_NONNULL_BEGIN

@interface SegmentForgetPasswordView : BaseSegmentView

@property (nonatomic, copy) SegmentForgetPasswordBlock passwordBlock;
@property (nonatomic, copy) NSString *phonePasswordCodeMessage;
- (void)segment_displayPasswordView;
- (void)segment_hidePasswordView;

@end

NS_ASSUME_NONNULL_END
