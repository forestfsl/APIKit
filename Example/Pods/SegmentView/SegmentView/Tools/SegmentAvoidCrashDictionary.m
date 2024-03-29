

#import "SegmentAvoidCrashDictionary.h"

#ifdef NSMutableDictionary
#undef NSMutableDictionary
#endif

#if  !__has_feature(objc_arc)
#define __bridge
#define __bridge_transfer
#endif

@implementation SegmentAvoidCrashDictionary

- (instancetype) init {
    self = [super init];
    if (self) {
        
    }
    return [self init_WithCapacity:0];
}


+ (void)removeAllObject{
    
}

+ (void)enumurateDevice{
    
}

+ (instancetype)dictionary
{
    return [[SegmentAvoidCrashDictionary alloc] init];
}

- (instancetype) initWithDictionary:(NSDictionary *)otherDictionary {
    self = [super init];
    if (self) {
        
    }
    if (otherDictionary) {
        return [self init_WithDictionary:otherDictionary];
    }
    return [self init_WithCapacity:0];
}


- (instancetype) init_WithCapacity:(NSUInteger)numItems {
    if ((self = [super init]) == nil) return nil;
    dictionary = CFDictionaryCreateMutable(kCFAllocatorDefault, numItems,
                                           &kCFTypeDictionaryKeyCallBacks,
                                           &kCFTypeDictionaryValueCallBacks);
    return self;
}

- (instancetype) init_WithDictionary:(NSDictionary *)otherDictionary {
    if ((self = [super init]) == nil) return nil;
    //    dictionary = CFDictionaryCreateMutable(kCFAllocatorDefault, 0,
    //                                           &kCFTypeDictionaryKeyCallBacks,
    //                                           &kCFTypeDictionaryValueCallBacks);
    
    CFDictionaryRef dictionaryRef = (__bridge CFDictionaryRef)otherDictionary;
    
    dictionary = CFDictionaryCreateMutableCopy(kCFAllocatorDefault,
                                               otherDictionary.count,
                                               dictionaryRef);
    return self;
}


- (void) dealloc {
    if (dictionary) {
        CFRelease(dictionary);
        dictionary = NULL;
    }
#if  !__has_feature(objc_arc)
    [super dealloc];
#endif
}

#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state
                                  objects:(id __unsafe_unretained [])stackbuf
                                    count:(NSUInteger)len
{
    return [super countByEnumeratingWithState:state objects:stackbuf count:len];
}

#pragma mark Querying Contents

- (NSUInteger)count
{
    return CFDictionaryGetCount(dictionary);
}

- (NSString*)debugDescription
{
    return (__bridge_transfer NSString*)CFCopyDescription(dictionary);
}

- (NSEnumerator*)keyEnumerator
{
    return [(__bridge id)dictionary keyEnumerator];
}

- (NSEnumerator*)objectEnumerator
{
    return [(__bridge id)dictionary objectEnumerator];
}

- (id)objectForKey:(id)aKey
{
    if ( aKey == nil){
        return nil;
    }
    return (__bridge id)CFDictionaryGetValue(dictionary, (__bridge const void *)aKey);
}

#pragma mark Modifying Contents

- (void)removeAllObjects
{
    CFDictionaryRemoveAllValues(dictionary);
}

- (void)removeObjectForKey:(id)aKey
{
    if ( aKey == nil){
        return;
    }
    CFDictionaryRemoveValue(dictionary, (__bridge const void *)aKey);
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    if (anObject == nil || aKey == nil){
        return;
    }
    CFDictionarySetValue(dictionary, (__bridge const void *)aKey, (__bridge const void *)anObject);
}


#pragma mark NSCoding

- (Class)classForKeyedArchiver
{
    return [self class];
}

- (instancetype)initWithCoder:(NSCoder*)decoder
{
    return [self initWithDictionary:[decoder decodeObjectForKey:@"dictionary"]];
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:(__bridge NSDictionary*)dictionary forKey:@"dictionary"];
}

- (void)encodeObject:(id)objv forKey:(NSString *)key
{
    NSLog(@"encodeObject=%@ forKey=%@", objv, key);
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone*) zone {
    // We could use allocWithZone here to keep they are both allocted in same region
    SegmentAvoidCrashDictionary *copy = [[[self class] allocWithZone:zone] init];
    [copy addEntriesFromDictionary:self];
    return copy;
}

@end
