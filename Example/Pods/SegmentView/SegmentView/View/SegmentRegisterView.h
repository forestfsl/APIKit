//
//  SegmentRegisterView.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "BaseSegmentView.h"

typedef void(^ProtocolBlock)(BOOL isProtocol);
typedef void(^RegisterViewBlock)(BOOL isBack,NSString * _Nullable userName,NSString * _Nullable password);

NS_ASSUME_NONNULL_BEGIN

@interface SegmentRegisterView : BaseSegmentView

@property (nonatomic, copy) RegisterViewBlock registerViewBlock;
@property (nonatomic, copy) ProtocolBlock protocolBlock;


+ (instancetype)sharedRegistViewInstance;

- (void)display_RegisterView;

- (void)hide_RegisterView;

- (void)showProtocolView:(BOOL)isProtocol;


@end

NS_ASSUME_NONNULL_END
