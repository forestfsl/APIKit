#import "UIImageView+Segment.h"
#import "CategoryMacro.h"




@implementation UIImageView (Segment)

+ (UIImageView *)createImageView{
    UIImageView *story_showBgImageV_boardA = [[UIImageView alloc]init];

    story_showBgImageV_boardA.image = kViewBgGradientImage
    
    return story_showBgImageV_boardA;
}


+ (UIImage *)createImageWithColor:(UIColor *)board_color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [board_color CGColor]);
    
    
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    return image;
}



+ (UIImage *)createCircleImageWithText:(NSString *)board_text story_bgColor:(UIColor *)story_bgColor story_size:(CGSize)story_size{
    NSDictionary *fontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:30], NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    CGSize textSize = [board_text sizeWithAttributes:fontAttributes];
    
    CGPoint drawPoint = CGPointMake((story_size.width - textSize.width)/2, (story_size.height - textSize.height)/2);
    
    UIGraphicsBeginImageContextWithOptions(story_size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, story_size.width, story_size.height)];
    
    CGContextSetFillColorWithColor(ctx, story_bgColor.CGColor);
    
    [path fill];
    
    [board_text drawAtPoint:drawPoint withAttributes:fontAttributes];
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImg;
}


+ (UIImage *)createDownTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor{
    UIGraphicsBeginImageContextWithOptions(board_size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(board_size.width/2,board_size.height)];
    [path addLineToPoint:CGPointMake(board_size.width, 0)];
    [path closePath];
    CGContextSetFillColorWithColor(ctx, board_tintColor.CGColor);
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


+ (UIImage *)createEnCloseDownTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor{
    UIGraphicsBeginImageContextWithOptions(board_size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(board_size.width/2,board_size.height)];
    [path addLineToPoint:CGPointMake(board_size.width, 0)];
    
    
    [path stroke];
    CGContextSetStrokeColorWithColor(ctx, board_tintColor.CGColor);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


+ (UIImage *)createUpTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor{
    UIGraphicsBeginImageContextWithOptions(board_size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, board_size.height)];
    [path addLineToPoint:CGPointMake(board_size.width/2,0)];
    [path addLineToPoint:CGPointMake(board_size.width, board_size.height)];
    [path closePath];
    CGContextSetFillColorWithColor(ctx, board_tintColor.CGColor);
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)createLongUpTriangleImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor{
    UIGraphicsBeginImageContextWithOptions(board_size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, board_size.height)];
    [path addLineToPoint:CGPointMake(board_size.width/2,0)];
    [path addLineToPoint:CGPointMake(board_size.width, board_size.height)];
    [path closePath];
    CGContextSetFillColorWithColor(ctx, board_tintColor.CGColor);
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


+ (UIImage *)createBackArrowImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor{
    UIGraphicsBeginImageContextWithOptions(board_size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(board_size.width, 0)];
    [path addLineToPoint:CGPointMake(0,board_size.height/2)];
    [path addLineToPoint:CGPointMake(board_size.width, board_size.height)];
    [path closePath];
    CGContextSetFillColorWithColor(ctx, board_tintColor.CGColor);
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


+ (UIImage *)createRightImageWithSize:(CGSize)board_size board_tintColor:(UIColor *)board_tintColor{
    UIGraphicsBeginImageContextWithOptions(board_size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(board_size.width,board_size.height/2)];
    [path addLineToPoint:CGPointMake(0, board_size.height)];
    [path closePath];
    CGContextSetFillColorWithColor(ctx, board_tintColor.CGColor);
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}




+ (UIImage *)createRectImageWithSize:(CGRect)board_frame board_tintColor:(UIColor *)board_tintColor{
    UIGraphicsBeginImageContextWithOptions(board_frame.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:board_frame];
    [path closePath];
    CGContextSetFillColorWithColor(ctx, board_tintColor.CGColor);
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


+ (UIImage *)createGradientColorWithRed:(CGFloat)story_red
                                            green:(CGFloat)green
                                             blue:(CGFloat)blue
                                       startAlpha:(CGFloat)startAlpha
                                         endAlpha:(CGFloat)endAlpha
                                        direction:(DirectionStyle)direction
                                            frame:(CGRect)frame{
    
    UIGraphicsBeginImageContext(frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGContextScaleCTM(context, frame.size.width, frame.size.height);
    
    
    CGGradientRef backGradient;
    
    if (direction == directionForDeviceStyleToUnderBoard) {
        
        CGFloat colors[] = {
            story_red, green, blue, startAlpha,
            story_red, green, blue, endAlpha,
        };
        backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    } else {
        
        CGFloat colors[] = {
            story_red, green, blue, startAlpha,
            story_red, green, blue, endAlpha,
        };
        backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    }
    
    
    CGColorSpaceRelease(rgb);
    
    CGContextDrawLinearGradient(context, backGradient, CGPointMake(0.5, 0), CGPointMake(0.5, 1), kCGGradientDrawsBeforeStartLocation);
    
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
@end
