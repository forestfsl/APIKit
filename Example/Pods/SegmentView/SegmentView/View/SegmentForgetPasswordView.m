#import "SegmentForgetPasswordView.h"
#import "SegmentConfigMacro.h"
#import "SegmentAvoidCrashDictionary.h"
#import "CategoryHeader.h"

@interface SegmentForgetPasswordView ()<UITextFieldDelegate>
//手机号码
@property (nonatomic, strong) SegmentTextField *phoneNumberField;
//验证码
@property (nonatomic, strong) SegmentTextField *verifyCodeField;
//新密码
@property (nonatomic, strong)  SegmentTextField *brandNewPassowordField;
//获取验证码按钮
@property (nonatomic, strong) UIButton *getVerifyCodeButton;
//倒计时
@property (nonatomic, assign) int countDownTime;
//定时器
@property (nonatomic, strong) NSTimer * countDownTimer;

//确定按钮
@property (nonatomic, strong) SegmentButton *sureBtn;
//关闭视图按钮
@property (nonatomic, strong) SegmentButton *cancelButton;

@end

@implementation SegmentForgetPasswordView

- (SegmentButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [SegmentButton storyboard_backbuttonForDevicebgBoardTarget:self action:@selector(storyboard_closePasswordView)];
    }
    return _cancelButton;
}

- (SegmentButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [SegmentButton storyboard_LongbuttonForDeviceBoardTitle:@"确定" target:self action:@selector(storyboard_resetPasswordCommit) isCornus:YES];
    }
    return _sureBtn;
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

- (SegmentTextField *)brandNewPassowordField{
    if (!_brandNewPassowordField) {
        _brandNewPassowordField = [[[SegmentTextField alloc]init] createTextFieldWithtarget:self placeholder:@"请输入新密码(6-20位数字或字母"];
    }
    return _brandNewPassowordField;
}

- (void)segment_configSubViews{
    
    [super segment_configSubViews];
    [self segment_configTopTitle:@"找回密码"];
    self.tag = StoryBoardForgetPasswordViewTag;
    [self.showBgView addSubview:self.cancelButton];
    [self.showBgView addSubview:self.titleLabel];
    [self.showBgView addSubview:self.phoneNumberField];
    [self.showBgView addSubview:self.verifyCodeField];
    [self.showBgView addSubview:self.getVerifyCodeButton];
    [self.showBgView addSubview:self.brandNewPassowordField];
    [self.showBgView addSubview:self.sureBtn];
}

- (UIButton *)getVerifyCodeButton{
    if (!_getVerifyCodeButton) {
        _getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _getVerifyCodeButton.frame = CGRectMake(0, 0, 80, 34);
        [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_getVerifyCodeButton setTitleColor:kBtnTitleColor forState:UIControlStateNormal];
        UIImage *verifyCodeImage = [UIImageView createRectImageWithSize:_getVerifyCodeButton.frame board_tintColor:kVerifyCodeBgColor];
        [_getVerifyCodeButton setBackgroundImage:verifyCodeImage forState:UIControlStateNormal];
        [_getVerifyCodeButton addTarget:self action:@selector(storyboard_getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _getVerifyCodeButton;
}



- (void)segment_displayPasswordView{
    [self show:self];
}

- (void)segment_hidePasswordView{
    [self hide:self];
}

- (void)segment_configConstraints{
    
    [super segment_configConstraints];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftMargin);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(kButtonH);
    }];
    
    [self.phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelButton.mas_bottom).offset(10);
        make.height.mas_equalTo(kTextFieldH);
        make.width.mas_equalTo(kCherryUIViewWidth - 2 * kLeftPadding);
        make.centerX.equalTo(self);
    }];
    [self.verifyCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumberField.mas_bottom).offset(kTextFieldTop);
        make.centerX.width.height.equalTo(self.phoneNumberField);
    }];
    [self.getVerifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.verifyCodeField);
        make.width.mas_equalTo(80);
    }];
    [self.brandNewPassowordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyCodeField.mas_bottom).offset(kTextFieldTop);
        make.centerX.width.height.equalTo(self.verifyCodeField);
    }];
    
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneNumberField);
        make.height.mas_equalTo(kButtonH);
        make.top.equalTo(self.brandNewPassowordField.mas_bottom).offset(kButtonTop + 10);
    }];
}





#pragma mark 关闭界面
- (void)storyboard_closePasswordView{
    if (self.passwordBlock) {
        self.passwordBlock(YES,nil);
    }
    
}

#pragma mark 重置密码
- (void)storyboard_resetPasswordCommit{
    NSString *tel = [self.phoneNumberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *verifyCode = [self.verifyCodeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *newPassword = [self.brandNewPassowordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (tel.length > 0 && verifyCode.length > 0 && newPassword.length) {
        if (verifyCode.length == 0) {
            [[CTMediator sharedInstance] segmentViewDisplayError:@"验证码不能为空"];
            return;
        }else if (newPassword.length < 6) {
            [[CTMediator sharedInstance] segmentViewDisplayError:@"密码不能低于6位"];
            return;
        }else {
            SegmentAvoidCrashDictionary *param = [SegmentAvoidCrashDictionary dictionary];
            [param setObject:tel forKey:[kParameterMap[@"phone"] fetchURLWords]];
            [param setObject:verifyCode forKey:[kParameterMap[@"code"] fetchURLWords]];
            [param setObject:newPassword forKey:[kParameterMap[@"password"] fetchURLWords]];
            if (self.passwordBlock) {
                self.passwordBlock(NO, param);
            }
            
            
        }
    }else{
        [[CTMediator sharedInstance] segmentViewDisplayError:@"手机号、验证码、密码均不能为空"];
        return;
    }
}


#pragma Mark-- 获取验证码
- (void)storyboard_getVerifyCode {
    //changeContent1
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
        [[CTMediator sharedInstance] request:param type:ForgetPasswordCodeRequest success:^(NSDictionary * _Nullable data) {
            self.countDownTime = 60;
            [self.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重试", self.countDownTime] forState:UIControlStateNormal];
            [self.getVerifyCodeButton setEnabled:NO];
            self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(storyboard_getCaptfchaCountDown) userInfo:nil repeats:YES];
             [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
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



#pragma mark - textField代理
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    textField.layer.borderColor = kTextFieldEditColor;
    if (textField == self.brandNewPassowordField) {
        if (self.brandNewPassowordField.secureTextEntry) {
            [self.brandNewPassowordField insertText:self.brandNewPassowordField.text];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = kTextFieldNormalColor;
}


@end
