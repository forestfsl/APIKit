
#import <Foundation/Foundation.h>

@interface NSData (Segment)


- (NSString *_Nullable)segmentBaseSixFourEncode;
- (NSData *_Nullable)segmentBXOREncryptWithKey:(NSString *_Nullable)appKey;


- (NSData *_Nullable)segmentBaseSixFourDecoded;
- (NSData *_Nullable)segmentXORDecryptWithAppKey:(NSString *_Nullable)appKey;


- (nullable NSData *)segmentDataZipped;
- (nullable NSData *)segmentGZipData;
- (BOOL)segmentIsZipped;



@end
