#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Segment)

- (NSString *)fetchURLWords;
- (NSString *)secretSha1:(NSString *)secret;

@end

NS_ASSUME_NONNULL_END
