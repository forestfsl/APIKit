#import "NSDictionary+Segment.h"

@implementation NSDictionary (Story)

- (NSString *)segment_FetchContentString:(NSString *)contentStr{
    NSString *result = @"";
    for (int i = 0; i < self.count; i ++) {
        NSString *keyString = [NSString stringWithFormat:@"%@", self.allKeys[i]];
        NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        int value = [[keyString stringByTrimmingCharactersInSet:nonDigits] intValue];
        if (value == [contentStr intValue]) {
            result = self[self.allKeys[i]];
            break;
        }
    }
    return result;
}

- (NSDictionary *)segmentMapData:(NSString *)param{
    NSDictionary *result = @{};
    for (int i = 0; i < self.count; i ++) {
        NSString *keyString = [NSString stringWithFormat:@"%@", self.allKeys[i]];
        NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        int value = [[keyString stringByTrimmingCharactersInSet:nonDigits] intValue];
        if (value == [param intValue]) {
            result = self[self.allKeys[i]];
            break;
        }
    }
    return result;
}

@end
