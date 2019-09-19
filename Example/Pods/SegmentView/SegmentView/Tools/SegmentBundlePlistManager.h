#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SegmentBundlePlistManager : NSObject


+ (NSBundle *)getResourceForDeviceBundle;

+ (UIImage *)getImageForDeviceNamed:(NSString *)name;

+ (NSString *)getGifForDeviceNamed:(NSString *)name;

#pragma mark 把账号密码写入plist
+ (void)writeToPlistForWebDict:(NSDictionary *)dict;

#pragma mark 从plist文件中读取账号密码
+ (NSArray *)readFromFroDevicePlist;

+ (BOOL)isHideReBtn;

@end

NS_ASSUME_NONNULL_END
