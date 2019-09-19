#import "SegmentButton.h"
#import "SegmentConfigMacro.h"
#import "CategoryHeader.h"

@implementation SegmentButton

+ (instancetype)storyboard_longtriabuttonForDeviceBoardTarget:(id)target action:(SEL)action isLeft:(BOOL)isLeft{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = kCircleButtonCornerRadius;
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kBtnHightlightColor forState:UIControlStateHighlighted];
    button.backgroundColor = kBtnBgColor;
    button.target = target;
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        
        
    }
    
    if (isLeft) {
        [button setImage:[UIImageView createBackArrowImageWithSize:CGSizeMake(30, 30) board_tintColor:kMainColor] forState:UIControlStateNormal];

    }else{
        [button setImage:[UIImageView createRightImageWithSize:CGSizeMake(30, 30) board_tintColor:kMainColor] forState:UIControlStateNormal];
    }
    
    return button;
}

+ (instancetype)storyboard_CirclebuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = kCircleButtonCornerRadius;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kBtnHightlightColor forState:UIControlStateHighlighted];
    button.backgroundColor = kBtnBgColor;
    button.target = target;
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        
        
    }
    return button;
}

+ (instancetype)storyboard_LongbuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action isCornus:(BOOL)isCornus{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    if (isCornus) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = kLongButtonCornerRadius;
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kBtnHightlightColor forState:UIControlStateHighlighted];
    button.backgroundColor = kBtnBgColor;
    button.target = target;
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        
        
    }
    
    return button;
}

+ (instancetype)storyboard_mediabuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = kMediaButtonCornerRadius;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kBtnHightlightColor forState:UIControlStateHighlighted];
    button.backgroundColor = kBtnBgColor;
    button.target = target;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

+ (instancetype)storyboard_shortbuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = kShortButtonCornerRadius;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kBtnHightlightColor forState:UIControlStateHighlighted];
    button.backgroundColor = kBtnBgColor;
    button.target = target;
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
    }
    return button;
    
}


+ (instancetype)storyboard_triabuttonDownForDeviceBoardTarget:(id)target action:(SEL)action{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImageView createDownTriangleImageWithSize:CGSizeMake(10, 10) board_tintColor:kMainColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    button.target = target;
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        
    }
    return button;
}

+ (instancetype)storyboard_triabuttonForDeviceBoardTarget:(id)target action:(SEL)action{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImageView createUpTriangleImageWithSize:CGSizeMake(10, 10) board_tintColor:kMainColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    button.target = target;
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        
    }
    return button;
}

+ (instancetype)storyboard_normalbuttonForDevicebgBoardTitle:(NSString *)title target:(id)target action:(SEL)action{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kLabelTextColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.target = target;
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        
    }
    return button;
}

+ (instancetype)storyboard_backbuttonForDevicebgBoardTarget:(id)target action:(SEL)action{
    SegmentButton *button = [SegmentButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImageView createBackArrowImageWithSize:CGSizeMake(10, 10) board_tintColor:kBtnBgColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    [button setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
    [button setTitleColor:kBtnHightlightColor forState:UIControlStateHighlighted];
    if (target && [target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        
    }
    return button;
}
@end
