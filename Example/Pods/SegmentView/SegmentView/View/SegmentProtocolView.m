//
//  SegmentProtocolView.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "SegmentProtocolView.h"
#import <WebKit/WebKit.h>

@interface SegmentProtocolView ()<WKNavigationDelegate,WKUIDelegate>
//背景
@property (nonatomic, strong) UIView *bgView;
//返回按钮
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) WKWebView *wewbView;
@property (nonatomic, strong) UIView *buttonBgView;
@end

@implementation SegmentProtocolView

- (void)segment_configSubViews{
    self.tag = StoryBoardProtocolViewTag;
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.buttonBgView];
    [self.buttonBgView addSubview:self.backButton];
    [self.bgView addSubview:self.wewbView];
    //changeContent1
}

- (void)segment_configConstraints{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kCherryUIViewWidth);
        make.height.mas_equalTo(kCherryUIViewHeight + 20);
    }];
    self.bgView.alpha = 0.0;
    [self.buttonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bgView);
        make.height.mas_equalTo(kButtonH + 10);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.height.width.mas_equalTo(kButtonH);
    }];
    [self.wewbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bgView);
        make.top.equalTo(self.buttonBgView.mas_bottom).offset(0);
    }];
}

- (void)showProtocolView:(BOOL)isProtocol{
    //changeContent1
    NSString *url = @"";
    if (isProtocol) {
        url = @"https://app.michub.online/ddd14";
    }else{
        url = @"https://app.michub.online/ddd15";
    }
    [[CTMediator sharedInstance] segmentViewAddTo:self animated:YES];
    [self.wewbView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark getter method
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 20;
        _bgView.backgroundColor = kBgViewColor;
    }
    return _bgView;
}

- (UIView *)buttonBgView{
    if (!_buttonBgView) {
        _buttonBgView = [[UIView alloc]init];
        _buttonBgView.backgroundColor = kBgViewColor;
    }
    return _buttonBgView;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [SegmentButton storyboard_backbuttonForDevicebgBoardTarget:self action:@selector(goBack)];
        _backButton.hidden = YES;
    }
    return _backButton;
}

- (WKWebView *)wewbView{
    if (!_wewbView) {
        _wewbView = [[WKWebView alloc]init];
        _wewbView.navigationDelegate = self;
        _wewbView.UIDelegate = self;
        _wewbView.scrollView.backgroundColor = kBgViewColor;
        _wewbView.allowsBackForwardNavigationGestures = YES;
    }
    return _wewbView;
}


- (void)goBack{
    //changeContent1
    [ChirsKeyWindow willRemoveSubview:self];
    if (self.protocolViewBlock) {
        self.protocolViewBlock();
    }
}
#pragma mark WKUIDelegate 代理事件

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    _backButton.hidden = NO;
    [UIView animateWithDuration:kUIAnimationDuration animations:^{
        self.bgView.alpha = 1.0;
    }];
    NSString *js = [NSString stringWithFormat:@"document.body.style.backgroundColor=%@%@%@",@"'",kBgViewColor,@"'"];
    
    [webView evaluateJavaScript:js completionHandler:nil];
    [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
   
    //changeContent1
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    _backButton.hidden = NO;
    [UIView animateWithDuration:kUIAnimationDuration animations:^{
        self.bgView.alpha = 1.0;
    }];
    NSString *js = [NSString stringWithFormat:@"document.body.style.backgroundColor=%@%@%@",@"'",kBgViewColor,@"'"];
    
    [webView evaluateJavaScript:js completionHandler:nil];
    
    [[CTMediator sharedInstance] segmentViewHiddenFrom:self animated:YES];
    //changeContent1
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    
    decisionHandler(actionPolicy);
    //changeContent1
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    
    
    if (navigationAction.navigationType==WKNavigationTypeBackForward) {
        
    }
    
    //changeContent1
    decisionHandler(actionPolicy);
}

#pragma mark WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    //changeContent1
}


- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    //changeContent1
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
}

@end
