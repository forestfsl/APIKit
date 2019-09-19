//
//  BaseSegmentView.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/11.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "BaseSegmentView.h"
#import "SegmentHeader.h"


@implementation BaseSegmentView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self configData];
    }
    return self;
}


- (void)configData{
    [self segment_configSubViews];
    [self segment_configConstraints];
    [self storyDataBoard];
    [self addNotifications];
    //changeContent1
}

- (void)segment_configSubViews{
    //changeContent1
    [self addSubview:self.showBgView];
    [self.showBgView addSubview:self.showBgImageV];
    [self.showBgView addSubview:self.titleLabel];
}


- (void)segment_configConstraints{
 
    [self.showBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kCherryUIViewWidth);
        make.height.mas_equalTo(kCherryUIViewHeight);
    }];
    
    [self.showBgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.showBgView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.showBgView);
        make.height.mas_equalTo(35);
    }];
    
    
}

- (void)storyUpDateConstraints{
    [self.base_currentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kCherryUIViewWidth);
        make.height.mas_equalTo(kCherryUIViewHeight);
    }];
    [self.showBgImageV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.showBgView);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.showBgView);
        make.height.mas_equalTo(42);
    }];
}


- (void)storyDataBoard{
    
}

- (void)storyInterfaceBoard:(id)data{
    
}

- (void)addNotifications{
    
}


- (void)show:(UIView *)theView{
    self.base_currentView = theView;
    __block UIView *mainView = theView;
    mainView.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    [UIView animateWithDuration:.2f
                          delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         mainView.alpha = 1;
                         mainView.transform = CGAffineTransformMakeScale(1.f, 1.f);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)showBgView:(UIView *)bgView{
    self.base_currentView = bgView;
    
    [self layoutIfNeeded];
    __block UIView *mainView = bgView;
    CGPoint startPosition = bgView.layer.position;
    bgView.layer.position = CGPointMake(startPosition.x, -startPosition.y);
    [UIView animateWithDuration:kUIAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        mainView.layer.position = startPosition;
        
    } completion:nil];
}

- (void)hideBgView:(UIView *)bgView{
    self.base_currentView = bgView;
    [self layoutIfNeeded];
    __block UIView *mainView = bgView;
    CGPoint startPosition = bgView.layer.position;
    CGPoint endPosition = bgView.layer.position;
    endPosition = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + startPosition.y);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        mainView.layer.position = endPosition;
    } completion:^(BOOL finished) {
        [self segment_removeSubViewFormKeyWindow];
    }];
}

- (void)hide:(UIView *)storytheViewBoard{
    self.base_currentView = storytheViewBoard;
    __block UIView *mainView = storytheViewBoard;
    [UIView animateWithDuration:.2f
                          delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         mainView.alpha = 0;
                         mainView.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
                     } completion:^(BOOL finished) {
                         
                     }];
}




- (void)segment_configTopTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)removeSubViewWithType:(NSInteger)fromType{
    UIView *subView = [ChirsKeyWindow viewWithTag:fromType];
    [self hide:subView];
}

- (void)segment_removeSubViewFormKeyWindow{
    //要是父view隐藏的情况下，有可能dealloc没有执行
    UIView *storyBoardloginView = [ChirsKeyWindow viewWithTag: StoryBoardLoginViewTag];
    [storyBoardloginView removeFromSuperview];
    storyBoardloginView = nil;
    UIView *storyBoardregisterSuccessView = [ChirsKeyWindow viewWithTag: StoryBoardRegisterSuccStoryBoardsViewTag];
    [storyBoardregisterSuccessView removeFromSuperview];
    storyBoardregisterSuccessView = nil;
    UIView *storyBoardregisterView = [ChirsKeyWindow viewWithTag: StoryBoardRegisterViewTag];
    [storyBoardregisterView removeFromSuperview];
    storyBoardregisterView = nil;
    UIView *storyBoardserviceView = [ChirsKeyWindow viewWithTag: StoryBoardCustomServiceViewTag];
    [storyBoardserviceView removeFromSuperview];
    storyBoardserviceView = nil;
    UIView *storyBoardpasswordView = [ChirsKeyWindow viewWithTag: StoryBoardForgetPasswordViewTag];
    [storyBoardpasswordView removeFromSuperview];
    storyBoardpasswordView = nil;
    UIView *storyBoarddisplayView = [ChirsKeyWindow viewWithTag: StoryBoardDisplayViewTag];
    [storyBoarddisplayView removeFromSuperview];
    storyBoarddisplayView = nil;
}


- (UIView *)showBgView{
    if (!_showBgView) {
        _showBgView = [UIView segmentCreateBgView];
    }
    return _showBgView;
}

- (UIImageView *)showBgImageV{
    if (!_showBgImageV) {
        _showBgImageV = [UIImageView createImageView];
    }
    return _showBgImageV;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel storyCreateLabelWithBoardTitle:@""];
    }
    return _titleLabel;
}

- (UIButton *)showPwdButton{
    if (!_showPwdButton) {
        _showPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showPwdButton setTitle:@"显示" forState:UIControlStateNormal];
        [_showPwdButton setTitle:@"隐藏" forState:UIControlStateSelected];
       [_showPwdButton setTitleColor:kBtnTitleColor forState:UIControlStateNormal];
        _showPwdButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _showPwdButton;
}

- (UITableView *)accountDropTableV{
    if (!_accountDropTableV) {
        _accountDropTableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _accountDropTableV.layer.borderWidth = 10;
        _accountDropTableV.layer.shadowRadius = 5;
        _accountDropTableV.layer.shadowColor = kTableViewBorderColor.CGColor;
        _accountDropTableV.layer.borderColor =  kTableViewBorderColor.CGColor;
        _accountDropTableV.separatorColor = kSperateLineColor;
        _accountDropTableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _accountDropTableV.alpha = 0.0;
    }
    return _accountDropTableV;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeAllSubViewWithType:(NSInteger)fromType{
    switch (fromType) {
        case StoryBoardViewFromLoginType:
        case StoryBoardViewFromForgetPasswordType:
        case StoryBoardViewFromBindPhoneType:
        case StoryBoardViewFromProtocolType:
        case StoryBoardViewFromCustomServiceType:
        case StoryBoardViewFromRegisterType:
        case StoryBoardRegisterViewTag:
            
        {
            [self segment_removeSubViewFormKeyWindow];
        }
            break;
            
        case StoryBoardRegisterSuccStoryBoardsViewTag:
        case StoryBoardViewFromDisplayType:
        {
            [self hideBgView:self.showBgView];
        }
        default:
            break;
    }
    
    //changeContent1
    [self destroySingleton];
}

- (void)destroySingleton{
    
}

@end
