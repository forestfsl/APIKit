

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Segment)

+ (UILabel *)storyCreateLabelWithBoardTitle:(NSString *)board_title_story;

+ (instancetype)createLabelWithTitle:(NSString *)title
                                  fontSize:(NSInteger)fontSize
                             textAlignment:(NSTextAlignment)textAlignment
                                 textColor:(UIColor *)textColor;


@end

NS_ASSUME_NONNULL_END
