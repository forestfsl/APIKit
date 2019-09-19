//
//  SegmentGameServiceView.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "BaseSegmentView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomServiceBlock)(void);

@interface SegmentGameServiceView : BaseSegmentView

+ (instancetype)sharedInstance;

@property (nonatomic, copy) CustomServiceBlock serviceBlock;


- (void)display_gameServiceView;
- (void)hide_gameServiceView;

@end

NS_ASSUME_NONNULL_END
