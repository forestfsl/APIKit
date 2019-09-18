#import "NSData+Segment.h"
#import <zlib.h>
#import <dlfcn.h>
#import <CommonCrypto/CommonDigest.h>

#pragma clang diagnostic ignored "-Wcast-qual"


@implementation NSData (Segment)


- (NSString *)segmentBaseSixFourEncode {
 
 
 
 
    return [self base64EncodedStringWithOptions:0];
}

- (NSData *)segmentBXOREncryptWithKey:(NSString *)appKey
{

    NSString const *privateKey = appKey;
    
   
    NSInteger length = privateKey.length;
    
  
    const char *keys = [privateKey cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cKey[length];
    
    memcpy(cKey, keys, length);
    
   
    NSMutableData *encryptData = [[NSMutableData alloc] initWithCapacity:length];
    
   
    const Byte *point = self.bytes;
    
    for (int i = 0; i < self.length; i++) {
        int l = i % length;
        char c = cKey[l];
        Byte b = (Byte) ((point[i]) ^ c);
        [encryptData appendBytes:&b length:1];  
    }
    
    return encryptData.copy;
}


- (NSData *)segmentBaseSixFourDecoded {

 
    return [[NSData alloc] initWithBase64EncodedData:self options:0];
}

- (NSData *)segmentXORDecryptWithAppKey:(NSString *)appKey
{

    return [self segmentBXOREncryptWithKey:appKey];
}


static void *libzOpen()
{
    static void *libz;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        libz = dlopen("/usr/lib/libz.dylib", RTLD_LAZY);
    });
    return libz;
}

- (NSData *)story_gzippedForDeviceCompressionLevelboardA:(float)level
{
    if (self.length == 0 || [self segmentIsZipped])
    {
        return self;
    }
    
    void *libz = libzOpen();
    int (*deflateInit2_)(z_streamp, int, int, int, int, int, const char *, int) =
    (int (*)(z_streamp, int, int, int, int, int, const char *, int))dlsym(libz, "deflateInit2_");
    int (*deflate)(z_streamp, int) = (int (*)(z_streamp, int))dlsym(libz, "deflate");
    int (*deflateEnd)(z_streamp) = (int (*)(z_streamp))dlsym(libz, "deflateEnd");
    
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.opaque = Z_NULL;
    stream.avail_in = (uint)self.length;
    stream.next_in = (Bytef *)(void *)self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;
    
    static const NSUInteger ChunkSize = 16384;
    
    NSMutableData *output = nil;
    int compression = (level < 0.0f)? Z_DEFAULT_COMPRESSION: (int)(roundf(level * 9));
    if (deflateInit2(&stream, compression, Z_DEFLATED, 15, 8, Z_DEFAULT_STRATEGY) == Z_OK)
    {
        output = [NSMutableData dataWithLength:ChunkSize];
        while (stream.avail_out == 0)
        {
            if (stream.total_out >= output.length)
            {
                output.length += ChunkSize;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            deflate(&stream, Z_FINISH);
        }
        deflateEnd(&stream);
        output.length = stream.total_out;
    }
    
    return output;
}

- (NSData *)segmentDataZipped
{
    return [self story_gzippedForDeviceCompressionLevelboardA:-1.0f];
}

- (NSData *)segmentGZipData
{
    if (self.length == 0 || ![self segmentIsZipped])
    {
        return self;
    }
    
    void *libz = libzOpen();
    int (*inflateInit2_)(z_streamp, int, const char *, int) =
    (int (*)(z_streamp, int, const char *, int))dlsym(libz, "inflateInit2_");
    int (*inflate)(z_streamp, int) = (int (*)(z_streamp, int))dlsym(libz, "inflate");
    int (*inflateEnd)(z_streamp) = (int (*)(z_streamp))dlsym(libz, "inflateEnd");
    
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.avail_in = (uint)self.length;
    stream.next_in = (Bytef *)self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;
    
    NSMutableData *output = nil;
    if (inflateInit2(&stream, 47) == Z_OK)
    {
        int status = Z_OK;
        output = [NSMutableData dataWithCapacity:self.length * 2];
        while (status == Z_OK)
        {
            if (stream.total_out >= output.length)
            {
                output.length += self.length / 2;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            status = inflate (&stream, Z_SYNC_FLUSH);
        }
        if (inflateEnd(&stream) == Z_OK)
        {
            if (status == Z_STREAM_END)
            {
                output.length = stream.total_out;
            }
        }
    }
    
    return output;
}

- (BOOL)segmentIsZipped
{
    const UInt8 *bytes = (const UInt8 *)self.bytes;
    return (self.length >= 2 && bytes[0] == 0x1f && bytes[1] == 0x8b);
}

+(NSData *)story_md5ForDeviceDigest:(NSData *)input {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    return [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

-(NSData *)story_md5ForDeviceDigest {
    return [NSData story_md5ForDeviceDigest:self];
}

+(NSString *)story_md5hexForDeviceDigestboardA:(NSData *)input {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

-(NSString *)story_md5hexForDeviceDigestboardA {
    return [NSData story_md5hexForDeviceDigestboardA:self];
}

@end
