//
//  CTMediator+SegmentViewHud.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (SegmentViewHud)
-(id)segmentViewDisplaySuccess:(NSString *)successMessage;
-(id)segmentViewDisplayError:(NSString *)errorMessage;
-(id)segmentViewAddTo:(id)target animated:(BOOL)animated;
-(id)segmentViewHiddenFrom:(id)target animated:(BOOL)animated;
-(id)segmentViewHide;

@end

NS_ASSUME_NONNULL_END
