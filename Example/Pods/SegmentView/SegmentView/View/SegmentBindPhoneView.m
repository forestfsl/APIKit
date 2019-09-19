//
//  SegmentBindPhoneView.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "SegmentBindPhoneView.h"

#import "SegmentAvoidCrashDictionary.h"

@interface SegmentBindPhoneView ()<UITextFieldDelegate>
//顶部提示绑定手机的标语
@property (nonatomic, strong) UILabel *tipLabel;
//号码
@property (nonatomic, strong) SegmentTextField *phoneNumberField;
//验证码
@property (nonatomic, strong) SegmentTextField *verifyCodeField;
//绑定手机按钮
@property (nonatomic, strong)  SegmentButton *bindPhoneButton;
//不绑定
@property (nonatomic, strong) SegmentButton *unbindPhoneButton;
//取消
@property (nonatomic, strong) UIButton *closeButton;
//获取验证码按钮
@property (nonatomic, strong) UIButton *getVerifyCodeButton;
//60秒倒计时
@property (assign, nonatomic) int countDownTime;
//定时器
@property (strong, nonatomic) NSTimer * countDownTimer;

@end



@implementation SegmentBindPhoneView

- (void)segment_configSubViews{
    self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
    [super segment_configSubViews];
    [self segment_configTopTitle:@"绑定手机"];
    [self.showBgView addSubview:self.tipLabel];
    [self.showBgView addSubview:self.phoneNumberField];
    [self.showBgView addSubview:self.verifyCodeField];
    [self.showBgView addSubview:self.getVerifyCodeButton];
    //    [self.showBgView addSubview:self.closeButton];
    [self.showBgView addSubview:self.unbindPhoneButton];
    [self.showBgView addSubview:self.bindPhoneButton];
}

- (void)segment_configConstraints{
    [super segment_configConstraints];
    
    self.showBgView.alpha = 0.0;
    [UIView animateWithDuration:kUIAnimationDuration animations:^{
        self.showBgView.alpha = 1.0;
    }];
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftMargin);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-kLeftMargin);
        make.height.mas_equalTo(34);
    }];
    [self.phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftMargin);
        make.right.mas_equalTo(-kLeftMargin);
        make.height.mas_equalTo(kTextFieldH);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(12);
    }];
    [self.verifyCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneNumberField);
        make.top.equalTo(self.phoneNumberField.mas_bottom).offset(12);
    }];
    [self.getVerifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.verifyCodeField);
        make.width.mas_equalTo(80);
    }];
    [self.unbindPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNumberField);
        make.width.mas_equalTo(kButtonShortW);
        make.height.mas_equalTo(kButtonH);
        make.top.equalTo(self.verifyCodeField.mas_bottom).offset(15);
    }];
    
    [self.bindPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.phoneNumberField);
        make.width.mas_equalTo(kButtonShortW);
        make.height.mas_equalTo(kButtonH);
        make.top.equalTo(self.verifyCodeField.mas_bottom).offset(15);
    }];
}


- (void)addNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storyboard_keyboardWhillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storyboard_keyboardWhillHide:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(storyboard_keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGestureRecognizer];
    
}


#pragma mark getter method



- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel storyCreateLabelWithBoardTitle:@"为了您的账号安全，请绑定手机号码"];
    }
    return _tipLabel;
}

- (SegmentButton *)unbindPhoneButton{
    if (!_unbindPhoneButton) {
        _unbindPhoneButton = [SegmentButton storyboard_mediabuttonForDeviceBoardTitle:@"暂不绑定" target:self action:@selector(didUnBindPhone)];
    }
    return _unbindPhoneButton;
}

- (SegmentButton *)bindPhoneButton{
    if (!_bindPhoneButton) {
        _bindPhoneButton = [SegmentButton storyboard_mediabuttonForDeviceBoardTitle:@"绑定手机" target:self action:@selector(didClickBindPhone)];
    }
    return _bindPhoneButton;
}


- (SegmentTextField *)phoneNumberField{
    if (!_phoneNumberField) {
        _phoneNumberField = [[[SegmentTextField alloc]init] createTextFieldWithtarget:self placeholder:@"请输入手机号"];
    }
    return _phoneNumberField;
}

- (SegmentTextField *)verifyCodeField{
    if (!_verifyCodeField) {
        _verifyCodeField = [[[SegmentTextField alloc]init] createTextFieldWithtarget:self placeholder:@"请输入验证码"];
    }
    return _verifyCodeField;
}

- (UIButton *)getVerifyCodeButton{
    if (!_getVerifyCodeButton) {
        _getVerifyCodeButton =  [SegmentButton storyboard_normalbuttonForDevicebgBoardTitle:@"获取验证码" target:self action:@selector(storyboard_getVerifyCode)];
        UIImage *verifyCodeBG = [UIImageView createRectImageWithSize:_getVerifyCodeButton.frame board_tintColor:kVerifyCodeBgColor];
        [_getVerifyCodeButton setBackgroundImage:verifyCodeBG forState:UIControlStateNormal];
        
    }
    return _getVerifyCodeButton;
}

#pragma mark 绑定手机
- (void)didClickBindPhone{
    [self.phoneNumberField resignFirstResponder];
    [self.verifyCodeField resignFirstResponder];
#if defined (DEBUG)||defined(_DEBUG)
    NSLog(@"点击了BindPhoneNumberView的绑定手机操作");
#endif
    
    NSString *tel = [self.phoneNumberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *verifyCode = [self.verifyCodeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!(tel.length > 0) || !(verifyCode.length > 0)) {
        [[CTMediator sharedInstance] segmentViewDisplayError:@"手机或验证码不能为空"];
       
        return;
    }

    SegmentAvoidCrashDictionary *param = [SegmentAvoidCrashDictionary dictionary];
  
    [param setObject:tel forKey:[kParameterMap[@"phone"] fetchURLWords]];
    [param setObject:verifyCode forKey:[kParameterMap[@"code"] fetchURLWords]];
    [param setObject:[[CTMediator sharedInstance] fetchAccessToken] forKey:[kParameterMap[@"access_token"] fetchURLWords]];
    [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
    [[CTMediator sharedInstance] request:param type:BindPhoneRequest success:^(NSDictionary * _Nullable data) {
        [self didClickCancel];
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
        [[CTMediator sharedInstance] segmentViewDisplaySuccess:@"绑定手机成功"];
    } fail:^(NSDictionary * _Nullable error) {
       NSString *errorMessage = error[@"msg"];
        [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
          [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    }];
}

#pragma Mark-- 获取验证码
- (void)storyboard_getVerifyCode {
    NSString *tel = [self.phoneNumberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    BOOL isValidTel = NO;
    if (tel.length > 0) {
        NSString *first = [tel substringToIndex:1];
        NSInteger length= tel.length;
        if ([first isEqualToString:@"1"] && length == 11) isValidTel = YES;
    }else{
        isValidTel = NO;
    }
    
    if (isValidTel) {
        NSDictionary *param = @{[kParameterMap[@"phone"] fetchURLWords] : tel};
        [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
        [[CTMediator sharedInstance] request:param type:BindPhoneCodeReuqest success:^(NSDictionary * _Nullable data) {
            [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
            self.countDownTime = 60;
            [self.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重试", self.countDownTime] forState:UIControlStateNormal];
            [self.getVerifyCodeButton setEnabled:NO];
            self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(storyboard_getCaptfchaCountDown) userInfo:nil repeats:YES];
        } fail:^(NSDictionary * _Nullable error) {
            NSString *errorMessage = error[@"msg"];
            [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
            [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
        }];
    }else{
         [[CTMediator sharedInstance] segmentViewDisplayError:@"请输入有效手机号码"];
        return;
    }
    
}

- (void)storyboard_getCaptfchaCountDown{
    self.countDownTime--;
    if (self.countDownTime == 0) {
        [self.countDownTimer invalidate];
        [self.getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getVerifyCodeButton setEnabled:YES];
    }else{
        [self.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重试", self.countDownTime] forState:UIControlStateNormal];
    }
}

#pragma mark 取消
- (void)didClickCancel{
    [ChirsKeyWindow willRemoveSubview:self];
    self.hidden = YES;
}

- (void)didUnBindPhone{
    [ChirsKeyWindow willRemoveSubview:self];
    self.hidden = YES;
}

- (void)storyboard_keyboardHide:(id)sender
{
    [self endEditing:YES];
}

- (void)storyboard_keyboardWhillShow:(NSNotification *)notification
{
    //获取键盘高度
    NSDictionary *dict=[notification userInfo];
    NSValue *value=[dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardrect = [value CGRectValue];
    int height=keyboardrect.size.height;
    CGFloat offset = self.showBgView.frame.origin.y + self.showBgView.frame.size.height - (self.frame.size.height - height);
    if (offset > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.showBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(-offset);
            }];
            [self layoutIfNeeded];
        }];
    }
}

- (void)storyboard_keyboardWhillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.showBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
        }];
        [self layoutIfNeeded];
    }];
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
