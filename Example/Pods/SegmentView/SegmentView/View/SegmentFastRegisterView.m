//
//  SegmentFastRegisterView.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "SegmentFastRegisterView.h"


@interface SegmentFastRegisterView ()
//保存账号密码按钮
@property (nonatomic, strong) SegmentButton *savePasswordAndAccountBtn;

//显示账号密码和提示
@property (nonatomic, strong) UIView *tipView;
//账号
@property (nonatomic, strong) UILabel *accountLabel;
//密码
@property (nonatomic, strong) UILabel *passwordLabel;
//分割线
@property (nonatomic, strong) UIView *sperateLineView;
//提示语
@property (nonatomic, strong) UILabel *bottomTipLabel;
//变量存储账号密码
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic ,strong) UILabel *ShowBoardTipLabel;
@end

@implementation SegmentFastRegisterView

- (UILabel *)ShowBoardTipLabel{
    if (!_ShowBoardTipLabel) {
        _ShowBoardTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, kScreenW, 30)];
        _ShowBoardTipLabel.text = @"用户名与密码随机生成，丢失后无法找回,请妥善保管,如果有其他问题，请联系我们客服，我们的服务热线时间是早上10点到晚上10点";
    }
    return _ShowBoardTipLabel;
}

- (void)animationTipLabel{
    CGRect frame = self.ShowBoardTipLabel.frame;
    frame.origin.x = kScreenW;
    self.ShowBoardTipLabel.frame = frame;
    [UIView beginAnimations:@"testAnimation"context:NULL];
    [UIView setAnimationDuration:6.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    frame = self.ShowBoardTipLabel.frame;
    frame.origin.x = -180 ;
    self.ShowBoardTipLabel.frame = frame;
    [UIView commitAnimations];
}

- (void)segment_configSubViews{
    [super segment_configSubViews];
    [self segment_configTopTitle:@"游客信息"];
    
    self.tipView = [[UIView alloc]init];
    self.tipView.layer.masksToBounds = YES;
    self.tipView.layer.cornerRadius = 10;
    self.tipView.backgroundColor = [UIColor whiteColor];
    
    self.accountLabel = [[UILabel alloc]init];
    self.accountLabel.font = [UIFont systemFontOfSize:14.0];
    self.accountLabel.textColor = kLabelTextColor;
    self.accountLabel.textAlignment = NSTextAlignmentLeft;
    
    self.passwordLabel = [[UILabel alloc]init];
    self.passwordLabel.font = [UIFont systemFontOfSize:14.0];
    self.passwordLabel.textColor = kLabelTextColor;
    self.passwordLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.sperateLineView = [[UIView alloc]init];
    self.sperateLineView.backgroundColor = kSperateLineColor;
    
    self.bottomTipLabel = [[UILabel alloc]init];
    self.bottomTipLabel.text = @"用户名与密码随机生成，丢失后无法找回,请妥善保管,如果有其他问题，请联系我们客服，我们的服务热线时间是早上10点到晚上10点";
    self.bottomTipLabel.font = [UIFont systemFontOfSize:12.0];
    self.bottomTipLabel.numberOfLines = 0;
    self.bottomTipLabel.textColor = kLabelTextColor;
    self.bottomTipLabel.textAlignment = NSTextAlignmentCenter;
    
    self.savePasswordAndAccountBtn = [SegmentButton storyboard_LongbuttonForDeviceBoardTitle:@"进入并保存账号密码" target:self action:@selector(didClickSavePasswordAndAccount) isCornus:YES];
    //changeContent1
    self.tag = StoryBoardRegisterViewTag;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 20;
    
    
    [self.showBgView addSubview:self.tipView];
    [self.tipView addSubview:self.accountLabel];
    [self.tipView addSubview:self.passwordLabel];
    [self.tipView addSubview:self.sperateLineView];
    [self.tipView addSubview:self.bottomTipLabel];
    [self addSubview:self.savePasswordAndAccountBtn];
    
}

- (void)showRegisterSuccessViewWithData:(id)data{
    //changeContent1
    [self show:self.showBgImageV];
    [self setupInterface:data];
}


//赋值数据
- (void)setupInterface:(id)data{
    //changeContent1
    NSString *username = [data segment_FetchContentString:kParameterMap[@"username"]];
    NSString *password = [data segment_FetchContentString:kParameterMap[@"password"]];
    self.password = password;
    self.username = username;
    self.accountLabel.text = [NSString stringWithFormat:@"%@%@",@"账号:",username];
    self.passwordLabel.text = [NSString stringWithFormat:@"%@%@",@"密码:",password];
    
    
    
}

- (void)segment_configConstraints{
    //changeContent1
    [super segment_configConstraints];

    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showBgView).offset(kTipViewPadding);
        make.right.equalTo(self.showBgView).offset(-kTipViewPadding);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kTipViewTop);
        make.height.mas_equalTo(kTipViewH);
    }];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tipView);
        make.left.mas_equalTo(5);
        make.height.mas_equalTo(kLabelH);
        make.top.mas_equalTo(5);
    }];
    [self.bottomTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-28);
        make.top.equalTo(self.sperateLineView.mas_bottom).offset(10);
        make.bottom.equalTo(self.tipView);
    }];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tipView);
        make.left.mas_equalTo(5);
        make.height.mas_equalTo(kLabelH);
        make.top.equalTo(self.accountLabel.mas_bottom).offset(5);
    }];
    [self.sperateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tipView);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.passwordLabel.mas_bottom).offset(10);
    }];
    
    
    [self.savePasswordAndAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kButtonH);
        make.top.equalTo(self.tipView.mas_bottom).offset(23);
        make.left.right.equalTo(self.tipView);
    }];
    
}


#pragma mark 点击保存账号密码
- (void)didClickSavePasswordAndAccount{
    if (self.registerSuccessViewBlock) {
        self.registerSuccessViewBlock(BYReplaceNil(self.username,@""),BYReplaceNil(self.password,@""));
    }
    
}



@end
