#import "UILabel+Segment.h"
#import "CategoryMacro.h"

@implementation UILabel (Segment)

+ (UILabel *)storyCreateLabelWithBoardTitle:(NSString *)board_title_story{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kLabelTextColor;
    titleLabel.text  = board_title_story;
    return titleLabel;
}

+ (instancetype)createLabelWithTitle:(NSString *)title
                                      fontSize:(NSInteger)fontSize
                                       textAlignment:(NSTextAlignment)textAlignment
                                     textColor:(UIColor *)textColor{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:fontSize];
    titleLabel.textAlignment = textAlignment;
    titleLabel.textColor = kLabelTextColor ;
    titleLabel.text  = title;
    return titleLabel;
}

@end
