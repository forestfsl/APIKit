
#import "SegmentBundlePlistManager.h"

#import <UIKit/UIKit.h>

#define bundleFileName @"StorySource"

@implementation SegmentBundlePlistManager

+ (NSBundle *)getResourceForDeviceBundle{
    NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:bundleFileName withExtension:@"bundle"];
    return [NSBundle bundleWithURL:bundleUrl];
}

+ (UIImage *)getImageForDeviceNamed:(NSString *)name{
    NSString *imagePath = [[SegmentBundlePlistManager getResourceForDeviceBundle].resourcePath stringByAppendingPathComponent:name];
    return [UIImage imageWithContentsOfFile:imagePath];
}


+ (NSString *)getGifForDeviceNamed:(NSString *)name{
    NSString *imagePath = [[SegmentBundlePlistManager getResourceForDeviceBundle].resourcePath stringByAppendingString:name];
    return imagePath;
}

+ (void)writeToPlistForWebDict:(NSDictionary *)dict{
       //changeContent1
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [paths objectAtIndex:0];
    NSString *Files = @"Account";
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *filePath =[NSString stringWithFormat:@"%@/%@",path,Files];
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"account.plist"];
    
    if (![fm fileExistsAtPath:plistPath]) {
        [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSMutableArray *dictplist = [[NSMutableArray alloc] init];
        [dictplist insertObject:dict atIndex:0];
        [dictplist writeToFile:plistPath atomically:YES];
        
    }else{
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        NSArray *tempArray = [NSArray arrayWithArray: array];
        if ([array containsObject:dict]) {
            [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *accountDict = tempArray[idx];
                if ([accountDict isEqualToDictionary:dict]) {
                    // 交换元素的位置，保持第一个始终为最近登录账号
                    [array exchangeObjectAtIndex:idx withObjectAtIndex:0];
                    *stop = YES;
                }
            }];
        }else {
               //changeContent1
            [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *accountDict = tempArray[idx];
                if ([dict[@"username"] isEqualToString:accountDict[@"username"]]){
                    [array replaceObjectAtIndex:idx withObject:dict];
                    *stop = YES;
                }else {
                    [array insertObject:dict atIndex:0];
                    *stop = YES;
                }
            }];
        }
        // 重新写入文件
        //changeContent1
        [array writeToFile:plistPath atomically:YES];
    }
}

+ (NSArray *)readFromFroDevicePlist{
       //changeContent1
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [paths objectAtIndex:0];
    NSString *Files = @"Account";
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString *filePath =[NSString stringWithFormat:@"%@/%@",path,Files];
    if (![fm fileExistsAtPath:filePath]) {
        [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * docDir = [filePath stringByAppendingPathComponent:@"account.plist"];
    NSArray *plistArray = [NSMutableArray arrayWithContentsOfFile:docDir];
    return plistArray;
}

+ (BOOL)isHideReBtn{
    NSArray *storyData = [self readFromFroDevicePlist];
    if (storyData.count > 0) {
        return  YES;
    }
    return NO;
}
@end
