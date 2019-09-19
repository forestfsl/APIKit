
#import "APIProgressHUD+Board.h"


@implementation APIProgressHUD (BY)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    APIProgressHUD *hud = [APIProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    // 设置图片
//    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageWithName:icon]];
//    hud.customView = imageview;
    // 再设置模式
    hud.mode = APIProgressHUDModeCustomView;
    // 隐藏时,从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1.5秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success" view:view];
}

#pragma mark 显示一些信息
+ (APIProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    APIProgressHUD *hud = [APIProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (APIProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:NO];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}



@end
