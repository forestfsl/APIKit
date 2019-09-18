

#import <UIKit/UIKit.h>
#import "StorySDKAPI.h"

//! Project version number for StorySDK.
FOUNDATION_EXPORT double StorySDKVersionNumber;

//! Project version string for StorySDK.
FOUNDATION_EXPORT const unsigned char StorySDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <StorySDK/PublicHeader.h>

//激活
#define active(appID,appKey) [StorySDKAPI activeWithAppID:appID unique_appKey:appKey]
#define fetchWorkName [StorySDKAPI ]

//登录
#define requestLogin [StorySDKAPI requestLogin]

#define authorize(userInfo) [StorySDKAPI requestAuthUserInfo:userInfo]

//注销
#define requesLoginout [StorySDKAPI requestLogout]

//购买
#define purchase(param)  [StorySDKAPI sendPurchaseRequest:param]

//获取sdk信息
#define fetchSDKInfo  [StorySDKAPI requestVersionInfo]

//changeContent1
