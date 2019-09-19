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

#import "SegmentConfigMacro.h"
#import "Target_SegmentViewHandler.h"
#import "SegmentAvoidCrashDictionary.h"
#import "SegmentBundlePlistManager.h"
#import "BaseSegmentView.h"
#import "SegmentBindPhoneView.h"
#import "SegmentFastRegisterView.h"
#import "SegmentForgetPasswordView.h"
#import "SegmentGameServiceView.h"
#import "SegmentHeader.h"
#import "SegmentMainView.h"
#import "SegmentProtocolView.h"
#import "SegmentRegisterView.h"
#import "SegmentAnimationManager.h"
#import "SegmentButton.h"
#import "SegmentCheckBoxGroup.h"
#import "SegmentCheckBoxManager.h"
#import "SegmentPathManager.h"
#import "SegmentTextField.h"

FOUNDATION_EXPORT double SegmentViewVersionNumber;
FOUNDATION_EXPORT const unsigned char SegmentViewVersionString[];

