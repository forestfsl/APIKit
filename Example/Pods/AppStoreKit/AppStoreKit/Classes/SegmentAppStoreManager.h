
#import <Foundation/Foundation.h>
#define Boot_FINISH_RETRY_MAX 3



typedef NS_ENUM(NSInteger, AppApiBootFailed) {
    

    AppApiBootForAStoreFailedAppNotAllow               = -1,
    
 
    AppApiBootForAStoreFailedInvalidFavorID          = 0,
    
    
    AppApiBootForAStoreFailedRequestFavorListFailed  = 1,
    

    AppApiBootForAStoreFailedTransactionStateFailed    = 2,
    

    AppApiBootForAStoreFailedTransactionStateRestored  = 3,
    

    AppApiBootForAStoreFailedUploadingReceiptFailed    = 4,
    
 
    AppApiBootForAStoreUploadingReceiptSuccessful      = 5
    
};

NS_ASSUME_NONNULL_BEGIN

@interface SegmentAppStoreManager : NSObject

+ (instancetype)sharedPurChaseManager;



- (void)board_purchaseProducts:(NSDictionary *)engine_parameter;

- (void)resendFailedForWebTransactionToServer;

@end

NS_ASSUME_NONNULL_END
