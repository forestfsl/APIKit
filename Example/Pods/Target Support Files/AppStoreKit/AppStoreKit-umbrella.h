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

#import "SegmentAppStoreManager.h"
#import "Target_PurchaseManager.h"

FOUNDATION_EXPORT double AppStoreKitVersionNumber;
FOUNDATION_EXPORT const unsigned char AppStoreKitVersionString[];

