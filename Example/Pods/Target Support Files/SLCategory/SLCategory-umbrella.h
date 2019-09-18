#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CategoryHeader.h"
#import "CategoryMacro.h"
#import "NSData+Segment.h"
#import "NSDictionary+Segment.h"
#import "NSString+Segment.h"
#import "UIImageView+Segment.h"
#import "UILabel+Segment.h"
#import "UITextField+Segment.h"
#import "UIView+Segment.h"

FOUNDATION_EXPORT double SLCategoryVersionNumber;
FOUNDATION_EXPORT const unsigned char SLCategoryVersionString[];

