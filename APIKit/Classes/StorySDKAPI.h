

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StorySDKAPI : NSObject


extern NSString *const kActivateForNotification;
extern NSString *const krequestLoginForNotification;
extern NSString *const kLoginCheckForNotification;
extern NSString *const kLogoutForNotification;
extern NSString *const kPurchaseForNotification;


extern NSString *const kuserID;
extern NSString *const kusername;
extern NSString *const ktoken;


extern NSString *const kCpOrderId;
extern NSString *const kGoodsId;
extern NSString *const kGoodsPrice;
extern NSString *const kServerId;
extern NSString *const kRoleId;
extern NSString *const kRoleName;
extern NSString *const kExtend;


+ (instancetype)board_sharedAPI_storyInstance;


+ (void)activeWithAppID:(NSString *)appID
                          unique_appKey:(NSString *)appKey;



+ (void)requestLogin;


+ (void)requestAuthUserInfo:(NSDictionary *)userInfo;



+ (void)requestLogout;


+ (void)sendPurchaseRequest:(NSDictionary *)params;



+ (NSDictionary *)requestVersionInfo;




@end

NS_ASSUME_NONNULL_END
