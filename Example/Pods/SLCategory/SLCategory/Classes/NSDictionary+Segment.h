#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Segment)

- (NSString *)segment_FetchContentString:(NSString *)contentStr;

- (NSDictionary *)segmentMapData:(NSString *)param;

@end

NS_ASSUME_NONNULL_END
