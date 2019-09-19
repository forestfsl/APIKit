//
//  SegmentFastRegisterView.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "BaseSegmentView.h"



typedef void(^RegisterSuccessViewBlock)(NSString * _Nullable userName,NSString * _Nullable password);

NS_ASSUME_NONNULL_BEGIN

@interface SegmentFastRegisterView : BaseSegmentView
@property (nonatomic, copy) SegmentViewPhotoCompleteBlock didFinishPhotoBlock ;
@property (nonatomic, copy) RegisterSuccessViewBlock registerSuccessViewBlock;

- (void)showRegisterSuccessViewWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
