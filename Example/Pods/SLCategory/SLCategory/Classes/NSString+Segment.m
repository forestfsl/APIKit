#import "NSString+Segment.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Segment)

- (NSString *)fetchURLWords{
    NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];
    NSArray *consts = @[@"b", @"c", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"m", @"n", @"p", @"qu", @"r", @"s", @"t", @"v", @"w", @"x", @"y", @"z", @"tt", @"ch", @"sh"];
    int len = arc4random() % 20+2;// length between 1-20
    NSString *word = @"";
    BOOL is_vowel = FALSE;
    NSArray *arr;
    
    for (int i = 0; i < len; i++) {
        if (is_vowel) {
            arr = vowels;
        } else {
            arr = consts;
        }
        is_vowel = !is_vowel;
        
        word = [NSString stringWithFormat:@"%@%@", word, arr[arc4random() % arr.count]];
    }
    return [NSString stringWithFormat:@"%@%@", word, self];
}

-(NSString *)secretSha1:(NSString *)secret {
    const char *cKey   = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData  = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC   = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return hash;
}

@end
