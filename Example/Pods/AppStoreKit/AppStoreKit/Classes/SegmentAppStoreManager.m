
#import "SegmentAppStoreManager.h"
#import <StoreKit/StoreKit.h>
#import "CTMediator+SegmentViewHud.h"
#import "CTMediator+RequestAPI.h"



@interface SegmentAppStoreManager()<SKProductsRequestDelegate,SKPaymentTransactionObserver>


@property (nonatomic, assign) int retryCount;

//产品id
@property (nonatomic, strong) NSString *pid;
//订单号
@property (nonatomic, strong) NSString *cid;

@property (nonatomic, strong) SKPaymentTransaction *transaction;

@end

#define kunloadFailureOrders @"unloanFailureOrders"

#define k1isStringEmpty(str) ((str) == nil || [(str) isKindOfClass:[NSNull class]] || [(str) isEqual:@""])
#define SegmentReplaceNil(value, defaultValue) (!k1isStringEmpty(value) ? value : defaultValue)

// 参数
#define k1ParameterMap @{@"username":@"1", @"password":@"2", @"authorize_code":@"3", @"access_token":@"4", @"id":@"5", @"bind_tel":@"6", @"msg":@"7", @"phone":@"8", @"code":@"9", @"type":@"10", @"count":@"11", @"sid":@"12", @"rid":@"13", @"role":@"14", @"pid":@"15", @"extend":@"16", @"cid":@"17", @"data":@"18", @"receipt":@"19", @"name":@"20", @"x":@"21", @"y":@"22", @"time":@"23", @"qq":@"24", @"tel":@"25", @"email":@"26", @"stamp":@"27",@"fork":@"28",@"public":@"29",@"wwdc":@"30",@"request":@"31"}

@implementation SegmentAppStoreManager

+ (instancetype)sharedPurChaseManager{
    static SegmentAppStoreManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SegmentAppStoreManager alloc]init];
    });
    return manager;
}
- (instancetype)init
{
    
   
    self = [super init];
    if (self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)board_purchaseProducts:(NSDictionary *)engine_parameter{
    
   //changeContent1
    self.cid = engine_parameter[@"cid"];
    self.pid = engine_parameter[@"pid"];
  
    [[CTMediator sharedInstance] segmentViewAddTo:[UIApplication sharedApplication].delegate.window animated:YES];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        if ([SKPaymentQueue canMakePayments]) {
            //请求对应的产品信息
            SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[[NSSet alloc] initWithObjects:self.pid, nil]];
            request.delegate = self;
            [request start];
            
        }else{
            [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
            [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreFailedAppNotAllow status:0];
        }
    });
}

#pragma mark - *** SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    //changeContent1
    SKProduct *preFavor = nil;
    NSArray *favors = response.products;
#if defined (DEBUG)||defined(_DEBUG)
    NSLog(@"----产品:%@", favors);
#endif
    
    

    if (favors.count == 0) {
        
      
        NSLog(@"无效ID:%@", response.invalidProductIdentifiers);
         [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
        [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreFailedInvalidFavorID status:0];
        
    }else{
       
        NSLog(@"产品种类数量:%lu", (unsigned long)[favors count]);
        for (SKProduct *favor in favors){
            if ([favor.productIdentifier isEqualToString:self.pid]) {
                preFavor = favor;
                break;
            }
        }
        if (preFavor) {
            SKPayment *Bootment = [SKPayment paymentWithProduct:preFavor];
            [[SKPaymentQueue defaultQueue] addPayment:Bootment];
        }else{
              [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
            [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreFailedInvalidFavorID status:0];
        }
    }
}


#pragma mark - *** SKRequestDelegate
- (void)requestDidFinish:(SKRequest *)reques{
    //TODO 可以自行处理一些其他操作
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    //changeContent1
       [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
    NSLog(@"请求列表失败：%@", [error localizedDescription]);
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
    [mDict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
    [mDict setObject:@"请求列表失败!" forKey:@"msg"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PurchaseNotification" object:nil userInfo:mDict];
    
}

#pragma mark 发送购买的通知
- (void)postPurchaseNotificationWithProductStatus:(NSInteger)appStoreStatus status:(int)status{
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
    [mDict setObject:[NSNumber numberWithInt:status] forKey:@"result"];
    [mDict setObject:@(appStoreStatus) forKey:@"msg"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PurchaseNotification" object:nil userInfo:mDict];
    
}

#pragma mark - *** SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    //changeContent1
    for(SKPaymentTransaction *transaction in transactions){
        
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchased:
            {
                self.retryCount = 0;
                // gm成功
                [self finishPurchase:@"订单号" updatedTransaction:transaction];
                
            }
                
                break;
                
            case SKPaymentTransactionStatePurchasing:
            {
                break;
            }
                
                
            case SKPaymentTransactionStateRestored:
            {
                
                [self showFailedAlert];
                  [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
                [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreFailedTransactionStateRestored status:0];
                
            }
                
                break;
                
            case SKPaymentTransactionStateFailed:
            {
                   //changeContent1
                [[CTMediator sharedInstance] segmentViewDisplayError:transaction.error.localizedDescription];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
                });
                
                [queue finishTransaction:transaction];
                [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreFailedTransactionStateFailed status:0];
                
                
            }
                break;
                
            default:
                break;
        }
    }
}

//备份数据
- (void)backTransactionWithUUID:(NSString *)uuid pid:(NSString *)orderID encodedTransactionReceipt:(NSString *)encodedTransactionReceipt productIdentifier:(NSString *)productIdentifier{
    //changeContent1
    NSMutableDictionary *orderDict = [NSMutableDictionary dictionaryWithCapacity:4];
    [orderDict setObject:uuid ? uuid : @"" forKey:@"uuid"];
    [orderDict setObject:orderID ? orderID : @"" forKey:@"orderID"];
    [orderDict setObject:encodedTransactionReceipt ? encodedTransactionReceipt : @"" forKey:@"encodedTransactionReceipt"];
    [orderDict setObject:productIdentifier ? productIdentifier : @"" forKey:@"productIdentifier"];
    @synchronized(self) {
        NSMutableDictionary *persistentOrdersDict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kunloadFailureOrders]];
        [persistentOrdersDict setObject:orderDict forKey:uuid.length > 0 ? uuid : @""];
        [[NSUserDefaults standardUserDefaults] setObject:persistentOrdersDict forKey:kunloadFailureOrders];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)clearTransactionWithUUID:(NSString *)uuid{
    //changeContent1
    @synchronized(self) {
        NSMutableDictionary *persistentOrdersDict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kunloadFailureOrders]];
        [persistentOrdersDict removeObjectForKey:uuid];
        [[NSUserDefaults standardUserDefaults] setObject:persistentOrdersDict forKey:kunloadFailureOrders];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)resendFailedForWebTransactionToServer{
    //changeContent1
    NSMutableDictionary *persistentOrders = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kunloadFailureOrders]];
    for (NSString *orderKey in persistentOrders) {
        NSDictionary *parameter = [persistentOrders objectForKey:orderKey];
        NSString *uuid = [parameter objectForKey:@"uuid"];
        NSString *orderId = [parameter objectForKey:@"orderID"];
        NSString *productIdentifier = [parameter objectForKey:@"productIdentifier"];
        NSString *encodedTransactionReceipt = [parameter objectForKey:@"encodedTransactionReceipt"];
        [self resendFailureOrderToServerWithUUID:uuid transactionReceipt:encodedTransactionReceipt pid:orderId productIdentifier:productIdentifier];
    }
}

- (void)resendFailureOrderToServerWithUUID:(NSString *)uuid transactionReceipt:(NSString *)transactionReceipt pid:(NSString *)orderID productIdentifier:(NSString *)productIdentifier{
    [self sendReceiptToServer:transactionReceipt Transaction:nil orderID:orderID];
}

#pragma mark - *** gm完成  将收据传给服务器
- (void) finishPurchase:(NSString *)each updatedTransaction:(SKPaymentTransaction *)transaction {
    //changeContent1
    NSData *receiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    if (!receiptData) {
   [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        return;
    }
    NSString *ret = [receiptData base64EncodedStringWithOptions:0];
    self.transaction = transaction;
    if (self.cid.length > 0) {
         [self backTransactionWithUUID:self.cid pid:self.cid encodedTransactionReceipt:ret productIdentifier:transaction.payment.productIdentifier];
         [self sendReceiptToServer:ret Transaction:transaction orderID:self.cid];
    }else{
        [self resendFailedForWebTransactionToServer];
    }
   
    
   
    
}

- (NSString *)fetchURLWordsWithWord:(NSString *)wordContent{
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
    return [NSString stringWithFormat:@"%@%@", word, wordContent];
}

- (void)sendReceiptToServer:(NSString *)receipt Transaction:(SKPaymentTransaction *)transaction orderID:(NSString *)orderID {
    NSMutableDictionary *uploadData = [NSMutableDictionary dictionary];


    [uploadData setObject:SegmentReplaceNil(orderID, @"") forKey:[self fetchURLWordsWithWord:k1ParameterMap[@"id"]]];
    [uploadData setObject:SegmentReplaceNil(receipt, @"") forKey: [self fetchURLWordsWithWord:k1ParameterMap[@"receipt"]]];
    [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
    [[CTMediator sharedInstance] request:uploadData type:UploadTransactionRequest success:^(NSDictionary * _Nullable data) {
          [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        
        [self clearTransactionWithUUID:self.cid];
        [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreUploadingReceiptSuccessful status:1];
    } fail:^(NSDictionary * _Nullable error) {

        [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreFailedUploadingReceiptFailed status:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.retryCount < Boot_FINISH_RETRY_MAX) {
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    NSLog(@"第%d次重试", self.retryCount + 1);
                    [self sendReceiptToServer:receipt Transaction:transaction orderID:orderID];
                    self.retryCount++;
                });
            }else{
                [self postPurchaseNotificationWithProductStatus:AppApiBootForAStoreFailedUploadingReceiptFailed status:0];
                NSLog(@"发货请求超时");
            }
              [[CTMediator sharedInstance] segmentViewHiddenFrom:[UIApplication sharedApplication].delegate.window animated:YES];
        });
    }];
   

}


- (void)showFailedAlert {
    
    [[CTMediator sharedInstance] segmentViewDisplayError:@"因故障问题未能成功发放，如果您已付款，请联系客服指引退款"];
}





@end
