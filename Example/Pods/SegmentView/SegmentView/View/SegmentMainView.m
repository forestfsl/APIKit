#import "SegmentMainView.h"
#import "SegmentRegisterView.h"
#import "SegmentGameServiceView.h"
#import "SegmentFastRegisterView.h"
#import "UITextField+Segment.h"
#import "SegmentAvoidCrashDictionary.h"
#import "SegmentProtocolView.h"

@interface SegmentMainView ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *bgUAcoutName;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) SegmentButton *selectAccountBtn;
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic) NSInteger selectIndex;
@property (nonatomic, strong) SegmentButton *loginBtn;
@property (nonatomic, strong) SegmentButton *registerBtn;
@property (nonatomic, strong) SegmentButton *contactBtn;
@property (nonatomic, strong) SegmentButton *fastLoginBtn;
@property (nonatomic, strong) SegmentButton *moreBtn;
@property (nonatomic, strong) UIView *moreView;
@property (nonatomic, strong) UIView *moreViewMask;
@property (nonatomic, strong) SegmentButton *moreTriangleBtn;


@property (nonatomic, strong) SegmentRegisterView *registerView;
@property (nonatomic, strong) SegmentGameServiceView *customServiceView;
@property (nonatomic, strong) SegmentFastRegisterView *cherry_RegisterSuccBoardView_treeA;


@end

@implementation SegmentMainView

static SegmentMainView *sharedInstance = nil;
static dispatch_once_t onceToken;

+ (instancetype)segment_createMainView{
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
        sharedInstance.tag = StoryBoardDisplayViewTag;
    });
    return sharedInstance;
}
- (void)segment_displayMainView{
    [self showBgView:self.showBgView];
}

-(UIView *)moreViewMask{
    if (!_moreViewMask) {
        _moreViewMask = [[UIView alloc]init];
        _moreViewMask.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _moreViewMask.alpha = 0;
    }
    return _moreViewMask;
}



- (UIView *)moreView{
    if (!_moreView) {
        _moreView = [[UIView alloc]init];
        _moreView.layer.masksToBounds = YES;
        _moreView.layer.cornerRadius = 5;
        
        _moreView.alpha = 0;
    }
    return _moreView;
}

- (void)storyDataBoard{
    //读取plist数据
    self.dataArr = [SegmentBundlePlistManager readFromFroDevicePlist];
    if (self.dataArr.count > 0) {
        NSDictionary *dict = [self.dataArr objectAtIndex:0];
        self.userNameTF.text = dict[@"username"];
        self.passwordTF.text = dict[@"password"];
    }
    //changeContent1
    [self changeShowPasswordBoardStatus:self.showPwdButton];
}
- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(es_keyboardWhillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(es_keyboardWhillHide:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(es_keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)segment_configSubViews{
    [ChirsKeyWindow addSubview:self];
    [super segment_configSubViews];
    self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
    self.userNameTF = [UITextField createHintTextForLeftLabel:@"账号:" placeholder:@"请输入账号"];
    self.passwordTF = [UITextField createHintTextForLeftLabel:@"密码:" placeholder:@"请输入密码"];
    self.userNameTF.backgroundColor = [UIColor whiteColor];
    self.passwordTF.backgroundColor = [UIColor whiteColor];
    self.selectAccountBtn = [SegmentButton storyboard_triabuttonForDeviceBoardTarget:self action:@selector(storyboard_selectAccountClick:)];
    
    [self.showPwdButton addTarget:self action:@selector(changeShowPasswordBoardStatus:) forControlEvents:UIControlEventTouchUpInside];
    
    [self SubviewFourCo];
    [self commonView];
    [self.showBgView addSubview:self.loginBtn];
    [self.showBgView addSubview:self.fastLoginBtn];
    [self.showBgView addSubview:self.registerBtn];
    [self.showBgView addSubview:self.contactBtn];
    //changeContent1
    self.accountDropTableV.delegate = self;
    self.accountDropTableV.dataSource = self;
    
    
}

- (void)commonView{
    [self segment_configTopTitle:@"主界面"];
    [self.showBgView addSubview:self.userNameTF];
    [self.showBgView addSubview:self.selectAccountBtn];
    [self.showBgView addSubview:self.passwordTF];
    [self.showBgView addSubview:self.showPwdButton];
    [self.showBgView addSubview:self.accountDropTableV];
}



- (void)clickMoreBoardone{
    [self clickMoreBoard:self.moreTriangleBtn];
}


- (void)SubviewFourCo{
    self.loginBtn = [SegmentButton  storyboard_LongbuttonForDeviceBoardTitle:@"登录" target:self action:@selector(clickLoginBoard) isCornus:YES];
    self.fastLoginBtn = [SegmentButton storyboard_LongbuttonForDeviceBoardTitle:@"游客" target:self action:@selector(clickFastRegBoard) isCornus:YES];
    self.registerBtn = [SegmentButton storyboard_LongbuttonForDeviceBoardTitle:@"注册" target:self action:@selector(clickRegisterBoard) isCornus:YES];
    self.contactBtn = [SegmentButton storyboard_LongbuttonForDeviceBoardTitle:@"客服" target:self action:@selector(contactBoardUS) isCornus:YES];
    
}

- (void)segment_configConstraints{
    
    
    [self.showBgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.showBgView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.showBgView);
        make.height.mas_equalTo(35);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
    
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftMargin);
        make.right.mas_equalTo(-kLeftMargin);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(kTextFieldH);
    }];
    [self.selectAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.height.equalTo(self.userNameTF);
        make.width.mas_equalTo(kTextFieldH);
    }];
    
    [self.accountDropTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.userNameTF);
        make.top.equalTo(self.userNameTF.mas_bottom).offset(-1);
        make.height.mas_equalTo(2 * kselectAccountBtnHeight);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTF.mas_bottom).mas_equalTo(kPasswordTFTop);
        make.left.right.height.equalTo(self.userNameTF);
    }];
    
    [self.showPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.height.equalTo(self.passwordTF);
        make.width.mas_equalTo(kTextFieldH);
    }];
    
    [self constraintFourCo];
}

- (void)constraintFourCo{
    [self.showBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kCherryUIViewWidth);
        make.height.mas_equalTo(kCherryUIViewHeight - 10);
    }];
    [self.fastLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameTF.mas_left).offset(0);
        make.height.mas_equalTo(kButtonH);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(15);
        make.width.mas_equalTo(kLongButtonW);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userNameTF.mas_right).offset(0);
        make.height.top.width.equalTo(self.fastLoginBtn);
    }];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.fastLoginBtn);
        make.top.equalTo(self.fastLoginBtn.mas_bottom).offset(10);
    }];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.width.equalTo(self.loginBtn);
        make.top.equalTo(self.registerBtn.mas_top);
    }];
}




- (void)clickMoreBoard:(UIButton *)sender{
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.3 animations:^{
        sender.imageView.transform = sender.selected ?CGAffineTransformMakeRotation(M_PI):CGAffineTransformMakeRotation(0);
        self.moreView.alpha =  sender.selected ? 1.0 : 0.0;
        self.moreViewMask.alpha = sender.selected ? 1.0 : 0.0;
    }];
}

#pragma mark 点击登录
- (void)clickLoginBoard{
    //changeContent1
    if (!(self.userNameTF.text.length > 0) || !(self.passwordTF.text.length > 0)) {
        [[CTMediator sharedInstance] segmentViewDisplayError:@"用户名或密码不能为空"];
        return;
    }
    [self normalLoginWithUserName:self.userNameTF.text password:self.passwordTF.text];
}

#pragma mark 登录
- (void)normalLoginWithUserName:(NSString *)username password:(NSString *)password{
    [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
    [[CTMediator sharedInstance] request:@{[kParameterMap[@"username"] fetchURLWords]:username,[kParameterMap[@"password"] fetchURLWords]:password} type:LoginRequest success:^(NSDictionary * _Nullable data) {
        [[CTMediator sharedInstance] configAuthCode:[data segment_FetchContentString:kParameterMap[@"authorize_code"]]];
        [SegmentBundlePlistManager writeToPlistForWebDict:@{@"username": username,@"password":password}];
        
        [self storyboard_postLoginNotificationWithTipText:@"登录成功" status:1];
        [[CTMediator sharedInstance] configLogin:YES];
    
        
        [self removeAllSubViewWithType:StoryBoardViewFromLoginType];
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
      
    } fail:^(NSDictionary * _Nullable error) {
         NSString *errorMessage = error[@"msg"];
        [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
         [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
        [self storyboard_postLoginNotificationWithTipText:@"登录失败" status:0];
         [[CTMediator sharedInstance] configLogin:NO];
    }];

}

#pragma mark 一键进入
- (void)clickFastRegBoard{
    if ([SegmentBundlePlistManager isHideReBtn]) {
     [[CTMediator sharedInstance] segmentViewDisplayError:@"你已经注册过，请用账号登录"];
        return;
    }
    if (self.moreView.alpha == 1) {
        [self clickMoreBoard:self.moreTriangleBtn];
    }
    [self showRegisterSuccessViewAction];
}

#pragma mark - 注册{
- (void)clickRegisterBoard{
    if (self.moreView.alpha == 1) {
        [self clickMoreBoard:self.moreTriangleBtn];
    }
    //changeContent1
    [ChirsKeyWindow addSubview:self.registerView];
    WEAK_SELF;
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(kCherryUIViewWidth);
        make.height.mas_equalTo(kCherryUIViewHeight);
    }];
    [self hide:self.showBgView];
    
    [self.registerView display_RegisterView];
    self.registerView.registerViewBlock = ^ (BOOL isBack,NSString *username,NSString *password){
        if (isBack) {
            [weakSelf show:weakSelf.showBgView];
            
            [[ChirsKeyWindow viewWithTag:StoryBoardRegisterViewTag] removeFromSuperview];
        }else{
            [weakSelf showNormalRegisterActionWithUserName:username password:password];
        }
        
    };
    _registerView.protocolBlock = ^(BOOL isProtocol){
        SegmentProtocolView *protocolView = [[SegmentProtocolView alloc]init];
        [ChirsKeyWindow addSubview:protocolView];
        [protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.mas_equalTo(kScreenW);
            make.height.mas_equalTo(kScreenH);
        }];
        [weakSelf hide:weakSelf.showBgView];
        
        [protocolView showProtocolView:isProtocol];
        protocolView.protocolViewBlock = ^{
            [weakSelf show:weakSelf.showBgView];
            [[ChirsKeyWindow viewWithTag:StoryBoardProtocolViewTag] removeFromSuperview];
        };
    };
}

#pragma mark 正常途径注册
- (void)showNormalRegisterActionWithUserName:(NSString *)userName password:(NSString *)password{
    [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
    [[CTMediator sharedInstance] request:@{[kParameterMap[@"username"] fetchURLWords]:userName,[kParameterMap[@"password"] fetchURLWords]:password} type:RegisterRequest success:^(NSDictionary * _Nullable data) {
        [SegmentBundlePlistManager writeToPlistForWebDict:@{@"username": userName,@"password":password}];
        [[CTMediator sharedInstance] configAuthCode:[data segment_FetchContentString:kParameterMap[@"authorize_code"]]];
        [self storyboard_postLoginNotificationWithTipText:@"登录成功" status:1];
        [[CTMediator sharedInstance] configLogin:YES];
      
        [self removeAllSubViewWithType:StoryBoardViewFromRegisterType];
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    } fail:^(NSDictionary * _Nullable error) {
         NSString *errorMessage = error[@"msg"];
        [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
         [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
          [[CTMediator sharedInstance] configLogin:NO];
    }];
    //changeContent1

}

#pragma mark 保存账号密码
- (void)saveUserNameAndPassword{
     [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
    [[CTMediator sharedInstance] request:@{[kParameterMap[@"username"] fetchURLWords]:self.bgUAcoutName,[kParameterMap[@"password"] fetchURLWords]:self.password} type:RegisterRequest success:^(NSDictionary * _Nullable data) {
        //changeContent1
        
       [[CTMediator sharedInstance] configAuthCode:[data segment_FetchContentString:kParameterMap[@"authorize_code"]]];
        [self storyboard_postLoginNotificationWithTipText:@"登录成功" status:1];
        [[CTMediator sharedInstance] configLogin:YES];
        //截图
        UIImage *image = [self storyboard_captureImageFromView:self.cherry_RegisterSuccBoardView_treeA];
        if (image) {
            
            [self storyboard_saveImageToPhotos:image completion:^{
                [self removeAllSubViewWithType:StoryBoardViewFromRegisterType];
                
                [SegmentBundlePlistManager writeToPlistForWebDict:@{@"username": self.bgUAcoutName,@"password":self.password}];
                
            }];
            //changeContent2
            
        }
         [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    } fail:^(NSDictionary * _Nullable error) {
       NSString *errorMessage = error[@"msg"];
        [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
        [[CTMediator sharedInstance] configLogin:NO];
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
        [self storyboard_postLoginNotificationWithTipText:@"登录失败" status:0];
    }];
  
    
}

#pragma mark 快速注册
- (void)showRegisterSuccessViewAction{
    //changeContent1
    [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
    [[CTMediator sharedInstance] request:@{} type:TouristRequest success:^(NSDictionary * _Nullable data) {
        [ChirsKeyWindow addSubview:self.cherry_RegisterSuccBoardView_treeA];
        [self.cherry_RegisterSuccBoardView_treeA mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kCherryUIViewWidth);
            make.height.mas_equalTo(kCherryUIViewHeight);
            make.center.offset(0);
        }];
        [self hide:self.showBgView];
        [self.cherry_RegisterSuccBoardView_treeA showRegisterSuccessViewWithData:data];
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    } fail:^(NSDictionary * _Nullable error) {
        NSString *errorMessage = error[@"msg"];
          [[CTMediator sharedInstance] segmentViewDisplayError:errorMessage];
        //changeContent2
        [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    }];
    
   
    
}

#pragma mark - 联系我们
- (void)contactBoardUS{
    if (self.moreView.alpha == 1) {
        [self clickMoreBoard:self.moreTriangleBtn];
    }
    self.customServiceView.hidden = NO;
    [self.customServiceView display_gameServiceView];
    [self hide:self.showBgView];
}


- (void)destroySingleton
{
    sharedInstance = nil;
    onceToken = 0;
}





#pragma mark 更改显示密码状态
- (void)changeShowPasswordBoardStatus:(UIButton *)button
{
    //changeContent1
    button.selected = !button.selected;
    self.passwordTF.secureTextEntry = button.selected;
    NSString *text = self.passwordTF.text;
    self.passwordTF.text = @" ";
    self.passwordTF.text = text;
    if (self.passwordTF.secureTextEntry) {
        [self.passwordTF insertText:self.passwordTF.text];
    }
}

#pragma mark 发送登录status的通知
- (void)storyboard_postLoginNotificationWithTipText:(NSString *)text status:(int)status{
    //changeContent1
    SegmentAvoidCrashDictionary *mDict = [[SegmentAvoidCrashDictionary alloc] init];
    [mDict setObject:[NSNumber numberWithInt:status] forKey:@"result"];
    [mDict setObject:BYReplaceNil([[CTMediator sharedInstance] fetchAuthCode], @"") forKey:@"authorize_code"];
    [mDict setObject:text forKey:@"msg"];
    //changeContent1
    [[NSNotificationCenter defaultCenter] postNotificationName:@"requestLoginNotification" object:nil userInfo:mDict];
}


#pragma mark 点击下拉框
- (void)storyboard_selectAccountClick:(UIButton *)sender{
    //changeContent1
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.3 animations:^{
        sender.imageView.transform = sender.selected ?CGAffineTransformMakeRotation(M_PI):CGAffineTransformMakeRotation(0);
        self.accountDropTableV.alpha =  sender.selected ? 1.0 : 0.0;
        [self.accountDropTableV reloadData];
        
    }];
}




- (void)es_keyboardHide:(id)sender
{
    [self endEditing:YES];
}

- (void)es_keyboardWhillShow:(NSNotification *)notification
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

- (void)es_keyboardWhillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.showBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
        }];
        [self layoutIfNeeded];
    }];
}


#pragma mark - **** 截图
- (UIImage *)storyboard_captureImageFromView:(UIView *)view{
    //changeContent1
    UIGraphicsBeginImageContextWithOptions(self.frame.size,NO, 0);
    [[UIColor clearColor] setFill];
    [[UIBezierPath bezierPathWithRect:self.bounds] fill];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




#pragma mark 保存图片
- (void)storyboard_saveImageToPhotos:(UIImage *)saveImage completion:(void (^)(void))completion{
    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    self.didFinishPhotoBlock = completion;
    //changeContent1
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
#if defined (DEBUG)||defined(_DEBUG)
        NSLog(@"存入手机相册成功");
#endif
        
        
        if (self.didFinishPhotoBlock) {
            self.didFinishPhotoBlock();
        }
        
    }else{
#if defined (DEBUG)||defined(_DEBUG)
        NSLog(@"存入手机相册失败");
#endif
        
        if (self.didFinishPhotoBlock) {
            self.didFinishPhotoBlock();
        }
        
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
    NSDictionary *accountDict = self.dataArr[indexPath.row];
    self.userNameTF.text = accountDict[@"username"];
    self.passwordTF.text = accountDict[@"password"];
    self.passwordTF.secureTextEntry = YES;
    [self storyboard_selectAccountClick:self.selectAccountBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *mainCell = @"MainCell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mainCell];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:mainCell];
    }
    NSDictionary *accountDict = self.dataArr[indexPath.row];
    cell.textLabel.text = accountDict[@"username"];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.frame = cell.frame;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = kBtnNormalColor;
    return cell;
    
}



- (SegmentGameServiceView *)customServiceView{
    if (!_customServiceView) {
        _customServiceView = [[SegmentGameServiceView alloc]init];
        WEAK_SELF;
        _customServiceView.serviceBlock = ^{
            [UIView animateWithDuration:kUIAnimationDuration animations:^{
                [weakSelf show:weakSelf.showBgView];
            }];
        };
    }
    return _customServiceView;
}

- (SegmentRegisterView *)registerView{
    if (!_registerView) {
        _registerView = [[SegmentRegisterView alloc]init];
    }
    return _registerView;
}

- (SegmentFastRegisterView *)cherry_RegisterSuccBoardView_treeA{
    if (!_cherry_RegisterSuccBoardView_treeA) {
        _cherry_RegisterSuccBoardView_treeA = [[SegmentFastRegisterView alloc]init];
        WEAK_SELF;
        _cherry_RegisterSuccBoardView_treeA.registerSuccessViewBlock = ^(NSString *username,NSString *password){
            weakSelf.bgUAcoutName = username;
            weakSelf.password = password;
            
            [weakSelf saveUserNameAndPassword];
        };
    }
    return _cherry_RegisterSuccBoardView_treeA;
}


@end
