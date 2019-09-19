//
//  SegmentRegisterView.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "SegmentRegisterView.h"
#import "SegmentCheckBoxManager.h"
#import "SegmentHeader.h"
#import "UITextField+Segment.h"
#import "SegmentAvoidCrashDictionary.h"

@interface SegmentRegisterView ()<SegmentCheckBoxManagerDelegate>
@property (nonatomic, strong) SegmentButton *cancelButton;
@property (nonatomic, strong) SegmentButton *registerBtn;
@property (nonatomic, strong) SegmentButton *loginButtonOne;
@property (nonatomic, strong) SegmentButton *loginButtonTwo;
@property (nonatomic, strong) SegmentButton *loginButtonThree;
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) SegmentCheckBoxManager *protocolCheckBox;
@property (nonatomic, strong) SegmentCheckBoxManager *praviteCheckBox;
@property (nonatomic, strong) UILabel *userProtocolLabel;
@property (nonatomic, strong) UILabel *privacyProtocolLabel;
@end

@implementation SegmentRegisterView

- (SegmentButton *)loginButtonOne{
    if (!_loginButtonOne) {
        _loginButtonOne = [SegmentButton buttonWithType:UIButtonTypeCustom];
        _loginButtonOne.titleLabel.text = @"快速登录";
        _loginButtonOne.backgroundColor = kMainColor;
        _loginButtonOne.hidden = YES;
    }
    return _loginButtonOne;
}

- (SegmentButton *)loginButtonTwo{
    if (!_loginButtonTwo) {
        _loginButtonTwo = [SegmentButton buttonWithType:UIButtonTypeCustom];
        _loginButtonTwo.titleLabel.text = @"游客登录";
        _loginButtonTwo.backgroundColor = kMainColor;
        _loginButtonTwo.hidden = YES;
    }
    return _loginButtonTwo;
}


- (SegmentButton *)loginButtonThree{
    if (!_loginButtonThree) {
        _loginButtonThree = [SegmentButton buttonWithType:UIButtonTypeCustom];
        _loginButtonThree.titleLabel.text = @"游客登录";
        _loginButtonThree.backgroundColor = kMainColor;
        _loginButtonThree.hidden = YES;
    }
    return _loginButtonThree;
}

static SegmentRegisterView *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedRegistViewInstance{
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.tag  = StoryBoardRegisterViewTag;
    });
    return instance;
    
}


- (SegmentButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [SegmentButton storyboard_LongbuttonForDeviceBoardTitle:@"注册" target:self action:@selector(didClickRegister) isCornus:YES];
    }
    return _registerBtn;
}


- (UITextField *)userNameTF{
    if (!_userNameTF) {
        _userNameTF = [UITextField createHintTextForLeftLabel:@"账号:" placeholder:@"请输入账号"];
        _userNameTF.backgroundColor = [UIColor whiteColor];
    }
    return _userNameTF;
}

- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [UITextField createHintTextForLeftLabel:@"密码:" placeholder:@"请输入密码"];
        _passwordTF.backgroundColor = [UIColor whiteColor];
    }
    return _passwordTF;
}

- (SegmentButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton =  [SegmentButton storyboard_LongbuttonForDeviceBoardTitle:@"返回" target:self action:@selector(storyboard_closeRegisterView) isCornus:YES];
    }
    return _cancelButton;
}

- (void)segment_configSubViews{
    [ChirsKeyWindow addSubview:self];
    
    [super segment_configSubViews];
    [self segment_configTopTitle:@"注册界面"];
    self.tag = StoryBoardRegisterViewTag;
    [self.showBgView addSubview:self.loginButtonThree];
    [self.showBgView addSubview:self.loginButtonTwo];
    [self.showBgView addSubview:self.loginButtonOne];
    
    [self.showBgView addSubview:self.userNameTF];
    [self.showBgView addSubview:self.passwordTF];
    [self.showBgView addSubview:self.protocolCheckBox];
    [self.showBgView addSubview:self.userProtocolLabel];
    [self.showBgView addSubview:self.praviteCheckBox];
    [self.showBgView addSubview:self.privacyProtocolLabel];
    [self.showBgView addSubview:self.registerBtn];
    [self.showBgView addSubview:self.cancelButton];
    
    
}


- (void)display_RegisterView{
    //changeContent1
    [self show:self];
}

- (void)hide_RegisterView{
    //changeContent1
    [self hide:self];
}

- (void)segment_configConstraints{
    [self.showBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        
    }];
    
    [self.showBgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.showBgView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.showBgView);
        make.height.mas_equalTo(42);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(kCherryUIViewWidth);
        make.height.mas_equalTo(kCherryUIViewHeight);
    }];
    
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftMargin);
        make.right.mas_equalTo(-kLeftMargin);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kUserNameTFTopPadding);
        make.height.mas_equalTo(kTextFieldH);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTF.mas_bottom).mas_equalTo(kPasswordTFTop);
        make.left.right.height.equalTo(self.userNameTF);
    }];
    
    
    [self.protocolCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameTF);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(kCheckboxTopMargin);
        make.width.mas_equalTo(kCheckBoxWidth);
        make.height.mas_equalTo(kCheckBoxHeight);
    }];
    [self.userProtocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.protocolCheckBox.mas_right).offset(2);
        make.top.equalTo(self.protocolCheckBox);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    
    [self.privacyProtocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userNameTF);
        make.top.equalTo(self.protocolCheckBox);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.praviteCheckBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.privacyProtocolLabel.mas_left).offset(-2);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(kCheckboxTopMargin);
        make.width.mas_equalTo(kCheckBoxWidth);
        make.height.mas_equalTo(kCheckBoxHeight);
        
    }];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.passwordTF);
        make.top.equalTo(self.praviteCheckBox.mas_bottom).offset(20);
        make.width.mas_equalTo(kLongButtonW);
        make.height.mas_equalTo(kButtonH);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passwordTF);
        make.top.equalTo(self.praviteCheckBox.mas_bottom).offset(20);
        make.width.mas_equalTo(kLongButtonW);
        make.height.mas_equalTo(kButtonH);
    }];
    
}




#pragma mark 显示协议
- (void)storyboard_showProtocol{
   [self showProtocolView:YES];
    
    
}

#pragma mark 显示隐私
- (void)storyboard_showPrivateAction{
   [self showProtocolView:NO];
    
    
}

- (void)showProtocolView:(BOOL)isProtocol{
    if (self.protocolBlock) {
        self.protocolBlock(isProtocol);
    }
}


#pragma mark 发送登录status的通知
- (void)storyboard_postLoginNotificationWithTipText:(NSString *)text status:(int)status{
    //changeContent1
    SegmentAvoidCrashDictionary *mDict = [[SegmentAvoidCrashDictionary alloc] init];
    [mDict setObject:[NSNumber numberWithInt:status] forKey:@"result"];
    //TODO
    [mDict setObject:BYReplaceNil([[CTMediator sharedInstance] fetchAuthCode] , @"") forKey:@"authorize_code"];
    [mDict setObject:text forKey:@"msg"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"requestLoginNotification" object:nil userInfo:mDict];
}


#pragma mark 注册
- (void)didClickRegister{
    if (!(self.passwordTF.text.length > 0)) {
        [[CTMediator sharedInstance] segmentViewDisplayError:@"请输入密码"];
        return;
    }else if (!(self.userNameTF.text.length > 0)) {
          [[CTMediator sharedInstance] segmentViewDisplayError:@"请输入账号"];
        return;
    }else if (_protocolCheckBox.on == NO ){
         [[CTMediator sharedInstance] segmentViewDisplayError:@"请选择用户协议"];
        return;
    }else if (_praviteCheckBox.on == NO) {
          [[CTMediator sharedInstance] segmentViewDisplayError:@"请选择用户隐私"];
        return;
    }
    if (self.registerViewBlock) {
        self.registerViewBlock(NO,BYReplaceNil(self.userNameTF.text, @""),BYReplaceNil(self.passwordTF.text, @""));
    }
    
}

- (void)storyboard_closeRegisterView{
    if (self.registerViewBlock) {
        self.registerViewBlock(YES, nil, nil);
    }
    
    
}


- (UILabel *)userProtocolLabel{
    if (!_userProtocolLabel) {
        _userProtocolLabel = [UILabel createLabelWithTitle:@"用户协议" fontSize:[k13FontSize integerValue] textAlignment:NSTextAlignmentCenter textColor:kTextLabelColor];
        NSString *plainString = @"用户协议";
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:plainString];
        
        [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attrString.length)];//下划线
        [attrString addAttribute:NSUnderlineColorAttributeName value:kTextLabelColor range:NSMakeRange(0, attrString.length)];
        _userProtocolLabel.attributedText = attrString;
        _userProtocolLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(storyboard_showProtocol)];
        [_userProtocolLabel addGestureRecognizer:tap];
    }
    return _userProtocolLabel;
}


- (UILabel *)privacyProtocolLabel{
    if (!_privacyProtocolLabel) {
        _privacyProtocolLabel = [UILabel createLabelWithTitle:@"隐私协议" fontSize:[k13FontSize integerValue] textAlignment:NSTextAlignmentCenter textColor:kTextLabelColor];
        NSString *plainString = @"隐私协议";
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:plainString];
        
        [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attrString.length)];
        [attrString addAttribute:NSUnderlineColorAttributeName value:kTextLabelColor range:NSMakeRange(0, attrString.length)];
        _privacyProtocolLabel.attributedText = attrString;
        _privacyProtocolLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(storyboard_showPrivateAction)];
        [_privacyProtocolLabel addGestureRecognizer:tap];
    }
    return _privacyProtocolLabel;
}

- (SegmentCheckBoxManager *)protocolCheckBox{
    if (!_protocolCheckBox) {
        _protocolCheckBox = [[SegmentCheckBoxManager alloc]init];
        _protocolCheckBox.delegate = self;
        _protocolCheckBox.layer.cornerRadius = 7.5;
        _protocolCheckBox.layer.borderColor = kCheckboxColor.CGColor;
        _protocolCheckBox.layer.borderWidth = 1.0;
        _protocolCheckBox.on = YES;
    }
    return _protocolCheckBox;
}

- (SegmentCheckBoxManager *)praviteCheckBox{
    if (!_praviteCheckBox) {
        _praviteCheckBox = [[SegmentCheckBoxManager alloc]init];
        _praviteCheckBox.delegate = self;
        
        _praviteCheckBox.layer.cornerRadius = 7.5;
        _praviteCheckBox.layer.borderColor = kCheckboxColor.CGColor;
        _praviteCheckBox.layer.borderWidth = 1.0;
        _praviteCheckBox.on = YES;
    }
    return _praviteCheckBox;
}

@end
