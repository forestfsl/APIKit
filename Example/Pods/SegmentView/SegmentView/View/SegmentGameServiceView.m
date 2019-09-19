#import "SegmentGameServiceView.h"
#import "SegmentForgetPasswordView.h"

@interface SegmentGameServiceView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SegmentButton *forgetPasswordBtn;
@property (nonatomic, strong) SegmentForgetPasswordView *passwordView;
@property (nonatomic, strong) SegmentButton *backButton;
@property (nonatomic, strong) UILabel *customLabel;
@property (nonatomic, strong) UIImageView *servicePhoneImageV;
@property (nonatomic, strong) UIImageView *serviceQQImageV;
@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UITableView *customServiceTableV;

@property (nonatomic, assign) BOOL isQQ;

@property (nonatomic, strong) NSArray *mainArray;

@property (nonatomic, strong) NSArray *leftImageArray;
@property (nonatomic, strong) NSArray *descArray;

@property (nonatomic, strong) UIView *footerView;

@end

@implementation SegmentGameServiceView

- (UIImageView *)servicePhoneImageV{
    if (!_servicePhoneImageV) {
        _servicePhoneImageV = [[UIImageView alloc]init];
        _servicePhoneImageV.layer.masksToBounds = YES;
        _servicePhoneImageV.layer.cornerRadius = 30;
        _servicePhoneImageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callServicePhone:)];
        [_servicePhoneImageV addGestureRecognizer:phoneTap];
    }
    return _servicePhoneImageV;
}


- (UIImageView *)serviceQQImageV{
    if (!_serviceQQImageV) {
        _serviceQQImageV = [[UIImageView alloc]init];
        _serviceQQImageV.userInteractionEnabled = YES;
        _serviceQQImageV.layer.masksToBounds = YES;
        _serviceQQImageV.layer.cornerRadius = 30;
        UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chatServiceQQ:)];
        [_serviceQQImageV addGestureRecognizer:phoneTap];
    }
    return _serviceQQImageV;
}


- (void)callServicePhone:(UITapGestureRecognizer *)gesture{
    if (self.descArray.count > 1) {
        [self storyboard_callTel:self.descArray[1]];
    }
    
}

- (void)chatServiceQQ:(UITapGestureRecognizer *)gesture{
    if (self.descArray.count > 0) {
        [self storyboard_sendMsgToQQ:self.descArray[0]];
    }
}

- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = @"让您与客户沟通更简单";
        _bottomLabel.font = [UIFont systemFontOfSize:[k12FontSize integerValue]];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = kLabelTextColor;
    }
    return _bottomLabel;
}

- (UILabel *)customLabel{
    if (!_customLabel) {
        _customLabel = [[UILabel alloc]init];
        _customLabel.text = @"客服中心";
        _customLabel.font = [UIFont systemFontOfSize:[k13FontSize integerValue]];
        _customLabel.textAlignment = NSTextAlignmentCenter;
        _customLabel.textColor = kLabelTextColor;
    }
    return _customLabel;
}

static SegmentGameServiceView *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedInstance{
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.tag = StoryBoardCustomServiceViewTag;
    });
    return instance;
}




- (void)segment_configSubViews{
    [ChirsKeyWindow addSubview:self];
    [super segment_configSubViews];
    self.tag = StoryBoardCustomServiceViewTag;
    
    [self segment_configTopTitle:@"联系我们"];
    [self.showBgView addSubview:self.titleLabel];
    [self.showBgView addSubview:self.customServiceTableV];
    [self.showBgView addSubview:self.footerView];
    self.forgetPasswordBtn = [SegmentButton storyboard_normalbuttonForDevicebgBoardTitle:@"忘记密码？" target:self action:@selector(showForgetPasswordView)];
    [self.showBgView addSubview:self.forgetPasswordBtn];
    
    
    
    [self configViewData];
}






- (SegmentForgetPasswordView *)passwordView{
    if (!_passwordView) {
        _passwordView = [[SegmentForgetPasswordView alloc]init];
    }
    return _passwordView;
}

- (void)display_gameServiceView{
    [self show:self];
}
- (void)hide_gameServiceView{
    [self hide:self];
}


- (void)configViewData{
    NSArray *mainArray = @[[NSString stringWithFormat:@"%@:%@",@"QQ",[[CTMediator sharedInstance] fetchQQText]]];
    self.mainArray = mainArray;
    self.isQQ = YES;
    self.descArray = @[[[CTMediator sharedInstance] fetchQQText],[[CTMediator sharedInstance] fetchEmailText]];
}


- (void)showForgetPasswordView{
    [ChirsKeyWindow addSubview:self.passwordView];
    WEAK_SELF;
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(kScreenH);
    }];
    [self hide:self.showBgView];
    [self.passwordView segment_displayPasswordView];
    self.passwordView.passwordBlock = ^(BOOL isBack,NSDictionary *parameter) {
        if (isBack) {
            [weakSelf show:weakSelf.showBgView];
            [[ChirsKeyWindow viewWithTag:StoryBoardForgetPasswordViewTag] removeFromSuperview];
        }else{
            [weakSelf resetPasswordWithParameter:parameter];
        }
        //changeContent3
    };
}

- (void)resetPasswordWithParameter:(NSDictionary *)param{
    [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
    
    [[CTMediator sharedInstance] request:param type:ForgetPasswordRequest success:^(NSDictionary * _Nullable data) {
        [self removeAllSubViewWithType:StoryBoardViewFromForgetPasswordType];
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    } fail:^(NSDictionary * _Nullable error) {
        NSString *errorMessage = error[@"msg"];
        [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    }];


    
    
}



- (void)segment_configConstraints{
    [super segment_configConstraints];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(kScreenH);
    }];
    
    self.showBgView.alpha = 0.0;
    [UIView animateWithDuration:kUIAnimationDuration animations:^{
        self.showBgView.alpha = 1.0;
    }];
    [self.customServiceTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44 * 2);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
    }];
    
    [self.forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.customServiceTableV).offset(10);
        make.top.equalTo(self.customServiceTableV.mas_bottom).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(kButtonH);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.equalTo(self.showBgView).offset(-30);
        make.height.mas_equalTo(44);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.mainArray[indexPath.row];
    cell.textLabel.textColor = kLabelTextColor;
    cell.backgroundColor = kTableViewCellColor;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *desText = self.descArray[indexPath.row];
    [self storyboard_clickCellAtIndexPath:indexPath desText:desText];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (void)storyboard_clickCellAtIndexPath:(NSIndexPath *)indexPath desText:(NSString *)desText{
    switch (indexPath.row) {
        case 0:
        {
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]){
                [self storyboard_sendMsgToQQ:desText];
            }else{
                [[CTMediator sharedInstance] segmentViewDisplayError:@"请先安装QQ，谢谢"];
            }
        }
            
            break;
            
        case 1:
            [self storyboard_callTel:desText];
            break;
            
        case 2:
            [self storyboard_sendEmailTo:desText];
            break;
            
        default:
            break;
    }
}

#pragma mark 打开qq
- (void)storyboard_sendMsgToQQ:(NSString *)qq{

    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
    {
        NSString *url = @"";
        if (self.isQQ) {
            url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qq];
        }else{
            url = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&card_type=group&source=qrcode",qq];
        }
        

            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
    }
}

#pragma mark 打开邮件
- (void)storyboard_sendEmailTo:(NSString *)email{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",email]];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

#pragma mark 拨打电话
- (void)storyboard_callTel:(NSString *)tel{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tel]];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}



- (UITableView *)customServiceTableV{
    if (!_customServiceTableV) {
        _customServiceTableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _customServiceTableV.separatorInset = UIEdgeInsetsZero;
        _customServiceTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _customServiceTableV.scrollEnabled = NO;
        _customServiceTableV.rowHeight = 44;
        _customServiceTableV.layer.masksToBounds = YES;
        _customServiceTableV.layer.cornerRadius = 5;
        _customServiceTableV.delegate = self;
        _customServiceTableV.dataSource = self;
        _customServiceTableV.backgroundColor = [UIColor clearColor];
        
    }
    return _customServiceTableV;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectZero];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.layer.cornerRadius = 15;
        [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kBtnNormalColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kBtnHightlightColor forState:UIControlStateHighlighted];
        cancelBtn.frame = CGRectMake(0, 0, kCherryUIViewWidth - 2 * kLeftMargin, kButtonH);
        cancelBtn.backgroundColor = kBtnBgColor;
        [cancelBtn addTarget:self action:@selector(didClickCustomServiceViewCancel) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:cancelBtn];
    }
    return _footerView;
}


#pragma mark 取消操作
- (void)didClickCustomServiceViewCancel{
    [ChirsKeyWindow willRemoveSubview:self];
    self.hidden = YES;
    if (self.serviceBlock) {
        self.serviceBlock();
    }
}



@end
