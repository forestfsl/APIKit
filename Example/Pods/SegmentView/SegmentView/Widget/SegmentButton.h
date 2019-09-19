#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SegmentButton : UIButton

@property (nonatomic, assign) id target;

+ (instancetype)storyboard_LongbuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action isCornus:(BOOL)isCornus;


+ (instancetype)storyboard_CirclebuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)storyboard_mediabuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action;


+ (instancetype)storyboard_shortbuttonForDeviceBoardTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)storyboard_longtriabuttonForDeviceBoardTarget:(id)target action:(SEL)action isLeft:(BOOL)isLeft;

+ (instancetype)storyboard_triabuttonForDeviceBoardTarget:(id)target action:(SEL)action;

+ (instancetype)storyboard_triabuttonDownForDeviceBoardTarget:(id)target action:(SEL)action;

+ (instancetype)storyboard_normalbuttonForDevicebgBoardTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)storyboard_backbuttonForDevicebgBoardTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
