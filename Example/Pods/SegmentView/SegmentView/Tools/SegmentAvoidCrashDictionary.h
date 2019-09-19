

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SegmentAvoidCrashDictionary : NSMutableDictionary{
    CFMutableDictionaryRef dictionary;
}


+ (void)removeAllObject;

+ (void)enumurateDevice;

+ (instancetype)dictionary;

- (id) init_WithCapacity:(NSUInteger)numItems;

- (instancetype) init_WithDictionary:(NSDictionary *)otherDictionary;

- (NSUInteger)count;

- (NSEnumerator*)keyEnumerator;

- (void)setObject:(id)anObject forKey:(id)aKey;

- (id)objectForKey:(id)aKey;

- (void)removeAllObjects;

- (void)removeObjectForKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
