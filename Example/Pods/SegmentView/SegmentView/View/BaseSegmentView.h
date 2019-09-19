//
//  BaseSegmentView.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/11.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentHeader.h"
#import "SegmentBundlePlistManager.h"
#import "SegmentConfigMacro.h"
#import "SegmentButton.h"
#import "SegmentTextField.h"
#import "CommonMarco.h"

typedef void(^SegmentViewPhotoCompleteBlock)(void);

typedef NS_ENUM(NSInteger, BaseSegmentViewTagType){
    StoryBoardLoginViewTag             = 13000,
    StoryBoardRegisterViewTag          = 3001,
    StoryBoardRegisterSuccStoryBoardsViewTag   = 3002,
    StoryBoardForgetPasswordViewTag    = 3003,
    StoryBoardBindPhoneViewTag         = 3004,
    StoryBoardCustomServiceViewTag     = 3005,
    StoryBoardProtocolViewTag          = 3006,
    StoryBoardDisplayViewTag           = 3007
};

typedef NS_ENUM(NSInteger, BaseSegmentViewFromType) {
    StoryBoardViewFromLoginType             = 4000,
    StoryBoardViewFromRegisterType          = 4001,
    StoryBoardViewFromRegisterSuccStoryBoardsType   = 4002,
    StoryBoardViewFromForgetPasswordType    = 4003,
    StoryBoardViewFromBindPhoneType         = 4004,
    StoryBoardViewFromCustomServiceType     = 4005,
    StoryBoardViewFromProtocolType          = 4006,
    StoryBoardViewFromDisplayType           = 4007
};


NS_ASSUME_NONNULL_BEGIN

@interface BaseSegmentView : UIView
@property (nonatomic, strong) UIView *base_currentView;
@property (nonatomic, copy) SegmentViewPhotoCompleteBlock didFinishPhotoBlock;

- (void)segment_configSubViews;


- (void)segment_configConstraints;
- (void)storyUpDateConstraints;


- (void)storyDataBoard;

- (void)storyInterfaceBoard:(id)data;

- (void)addNotifications;


- (void)show:(UIView *)theView;
- (void)showBgView:(UIView *)bgView;
- (void)hideBgView:(UIView *)bgView;
- (void)hide:(UIView *)storytheViewBoard;


@property (nonatomic, strong) UITableView *accountDropTableV;

@property (nonatomic, strong) UIButton *showPwdButton;


@property (nonatomic, strong) UIView *showBgView;
@property (nonatomic, strong) UIImageView *showBgImageV;
@property (nonatomic, strong) UILabel *titleLabel;


- (void)segment_configTopTitle:(NSString *)title;

- (void)segment_removeSubViewFormKeyWindow;

- (void)removeAllSubViewWithType:(NSInteger)fromType;

- (void)removeSubViewWithType:(NSInteger)fromType;

- (void)destroySingleton;



@end

NS_ASSUME_NONNULL_END
