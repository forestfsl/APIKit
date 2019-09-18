
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Segment)

+ (UITextField *)createTFWithPlaceholder:(NSString *)placeholder leftImage:(UIImage *)image;

+ (UITextField *)createHintTextForLeftLabel:(NSString *)hintText placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
