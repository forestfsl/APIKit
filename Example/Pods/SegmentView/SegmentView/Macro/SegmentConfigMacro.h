//
//  SegmentConfigMacro.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/11.
//  Copyright © 2019 fengsl. All rights reserved.
//

#ifndef SegmentConfigMacro_h
#define SegmentConfigMacro_h


#define signleton_h(name) + (instancetype)shared##name;
#define signleton_m(name) static id _instance;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
\
+ (instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}

//changeMacro

#define WEAK_SELF __weak __typeof(&*self)weakSelf = self
#define STRONG_SELF(self) __strong __typeof(&*self) strongSelf = self


#define isStringEmpty(str) ((str) == nil || [(str) isKindOfClass:[NSNull class]] || [(str) isEqual:@""])


#define BYReplaceNil(value, defaultValue) (!isStringEmpty(value) ? value : defaultValue)

#define kSDKVersion @"1.0.0"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]/// rgb颜色转换（16进制->10进制）


#define kBgViewColor  UIColorFromRGB(0xc2fcf6)


#define kIconBackground @""

#define kMainColor  UIColorFromRGB(0xfff0f8)




#define kBtnSelectedColor UIColorFromRGB(0x2e5a1c)

#define kBtnBackGroundColor UIColorFromRGB(0x63686e)

#define kBtnImageBGColor  UIColorFromRGB(0x2bce7f)

#define kViewBgColor UIColorFromRGB(0x2bce7f)

#define kSperateLineColor UIColorFromRGB(0xB0AFD7)

#define kTFPlaceholderColor UIColorFromRGB(0xA8A8A8)

#define kTFBgColor UIColorFromRGB(0xffffff)

#define kChirsWhiteColor [UIColor whiteColor]

#define kTextLabelColor UIColorFromRGB(0x5BC1FF)

#define kSmilePathColor UIColorFromRGB(0x00bd56)

//changeMacro
//changeMacro
#define  kArrowColor UIColorFromRGB(0x2e5a1c)

#define kBgAlpah 0.70
#define kBgWhite 0.5


#define  kVerifyCodeBgColor UIColorFromRGB(0x373640)






#define kCheckboxColor [UIColor whiteColor]



#define k12FontSize @"12"

#define k13FontSize @"13"
//changeMacro
#define k14FontSize @"14"

#define k16FontSize @"16"

#define ChirsKeyWindow [UIApplication sharedApplication].delegate.window

#define kUIAnimationDuration 0.5
#define kSperateLineHeight 0.5

#define kCircleButtonCornerRadius 30
#define kCircleButtonW  63
#define kCircleButtonH 64

#define kLongButtonCornerRadius 15
#define kMediaButtonCornerRadius 10
#define kShortButtonCornerRadius 5
#define kShortButtonW 80
#define kMediaButtonW 100

#define kLeftMargin 15
#define kTextFieldH 42
#define kTextFieldTopMargin 5
#define kCheckboxTopMargin 15
#define kButtonH 35
#define kButtonTopMargin 10
#define kUIImageViewTopMargin 15
#define kUIImageViewH 50
#define kUILabelH 25
#define kUILabelW 50
#define kUILabelLeftMarggin 5
#define kCheckBoxWidth 15
#define kCheckBoxHeight 15
#define kTitleLabelH 42
//changeMacro
#define kLabelH 14
#define kTipViewTop 15
#define kTipViewPadding 15
#define kTipViewH 125
#define kButtonTop 10
#define kButtonW 70
#define kLongButtonW 130

#define kFastButtonW 120

#define kTextFieldTop 10
#define kLeftPadding 15
#define kCloseTop 4
#define kCloseRight 4
#define kcancelButtonW 60
#define kCherryUIViewHeight 270
#define kCherryUIViewWidth 314
#define kButtonShortW 100

#define kStoryLoginViewH 200
#define kStoryLoginViewW 300

#define kBtnBgColor UIColorFromRGB(0x5BC1FF)
#define kforgetPwdBgColor UIColorFromRGB(0xf69314)
#define kLoginBgColor UIColorFromRGB(0x00bd56)
#define kVisitorBgColor UIColorFromRGB(0x8b5d5d)

#define kCustomBgColor UIColorFromRGB(0x5BC1FF)
#define kRegisterBgColor UIColorFromRGB(0x1d1919)
#define kBtnNormalColor UIColorFromRGB(0xffffff)

#define kUserNameTFTopPadding 10

#define kPasswordTFTop 12
#define kLabelW 55

#define kLabelTop 12

#define kLoginBtnTop 20
#define kselectAccountBtnHeight 40


#define kBtnHightlightColor UIColorFromRGB(0x1f4287)

#define kTextFieldNormalColor [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.8627 alpha:1.0].CGColor

#define kTextFieldEditColor [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.8627 alpha:1.0].CGColor

//changeMacro
#define kTitleLabelH 42
#define kLabelH 14
#define kTipViewTop 15
#define kTipViewPadding 15
#define kTipViewH 125
#define kButtonTop 10


#define bundleFileName @"StorySource"

#define kDefineNew 0
#define kDefineOneCo 0
#define kDefineTwoCo 0
#define kDefineThreeCo 1

#define kViewBgCorner 10

#define kTableViewBorderColor UIColorFromRGB(0xE6E6FA)


#define kTableViewCellColor  UIColorFromRGB(0xf7f7f7)



#define kTextFieldBgColor UIColorFromRGB(0xffffff)

#define kLabelTextColor UIColorFromRGB(0x5BC1FF)

#define kTextfieldPlaceColor UIColorFromRGB(0x313131)



#define BYReplaceNil(value, defaultValue) (!isStringEmpty(value) ? value : defaultValue)

#define kCircleButtonCornerRadius 30
#define kCircleButtonW  63
#define kCircleButtonH 64
#define kTextFieldTop 10
#define kLeftPadding 15
#define kCloseTop 4

#define kCloseRight 4

#define kBtnTitleColor  UIColorFromRGB(0x2c003e)

#define kBtnSelectedColor UIColorFromRGB(0x2e5a1c)

#define kBtnBackGroundColor UIColorFromRGB(0x63686e)



#define kCheckBoxTop 8


#define kBtnTop 20



#endif /* SegmentConfigMacro_h */
