

#import <UIKit/UIKit.h>
#import "MagicWorldAPI.h"

//! Project version number for StorySDK.
FOUNDATION_EXPORT double StorySDKVersionNumber;

//! Project version string for StorySDK.
FOUNDATION_EXPORT const unsigned char StorySDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <StorySDK/PublicHeader.h>

//激活
#define active(appID,appKey) [MagicWorldAPI activeWithAppID:appID unique_appKey:appKey]
#define fetchWorkName [MagicWorldAPI ]

//登录
#define requestLogin [MagicWorldAPI requestLogin]

#define authorize(userInfo) [MagicWorldAPI requestAuthUserInfo:userInfo]

//注销
#define requesLoginout [MagicWorldAPI requestLogout]

//购买
#define purchase(param)  [MagicWorldAPI sendPurchaseRequest:param]

//获取sdk信息
#define fetchSDKInfo  [MagicWorldAPI requestVersionInfo]

