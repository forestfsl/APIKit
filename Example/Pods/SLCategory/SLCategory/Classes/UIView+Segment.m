#import "UIView+Segment.h"

#define kViewBgCorner 10

@implementation UIView (Segment)

+ (UIView *)segmentCreateBgView{
    UIView *story_showBgView_boardA = [[UIView alloc]init];
    story_showBgView_boardA.layer.masksToBounds = YES;
    story_showBgView_boardA.layer.cornerRadius = kViewBgCorner;
    return story_showBgView_boardA;
}

@end
