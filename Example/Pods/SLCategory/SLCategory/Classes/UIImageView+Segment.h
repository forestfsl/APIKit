#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DirectionStyle){
    directionForDeviceStyleToUnderBoard = 0,
    directionForDeviceStyleToUnBoard = 1
};


NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Segment)

+ (UIImageView *)createImageView;

+ (UIImage *)createImageWithColor:(UIColor *)board_color;

+ (UIImage *)createCircleImageWithText:(NSString *)board_text story_bgColor:(UIColor *)story_bgColor story_size:(CGSize)story_size;


+ (UIImage *)createDownTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor;


+ (UIImage *)createEnCloseDownTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor;


+ (UIImage *)createUpTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor;

+ (UIImage *)createLongUpTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor;


+ (UIImage *)createBackArrowImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor;


+ (UIImage *)createRightImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor;



+ (UIImage *)createRectImageWithSize:(CGRect)board_frame board_tintColor:(UIColor *)board_tintColor;


+ (UIImage *)createGradientColorWithRed:(CGFloat)story_red
                                            green:(CGFloat)green
                                             blue:(CGFloat)blue
                                       startAlpha:(CGFloat)startAlpha
                                         endAlpha:(CGFloat)endAlpha
                                        direction:(DirectionStyle)direction
                                            frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
