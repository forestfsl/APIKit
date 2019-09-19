//
//  SegmentProtocolView.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "BaseSegmentView.h"

typedef void(^ProtocolViewBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SegmentProtocolView : BaseSegmentView
@property (nonatomic, copy) ProtocolViewBlock protocolViewBlock;
- (void)showProtocolView:(BOOL)isProtocol;

@end

NS_ASSUME_NONNULL_END
