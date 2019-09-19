//
//  SegmentMainView.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "BaseSegmentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SegmentMainView : BaseSegmentView

+ (instancetype)segment_createMainView;
- (void)segment_displayMainView;
@end

NS_ASSUME_NONNULL_END
