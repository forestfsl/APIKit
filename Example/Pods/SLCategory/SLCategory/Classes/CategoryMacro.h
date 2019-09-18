//
//  CategoryMacro.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/11.
//  Copyright © 2019 fengsl. All rights reserved.
//

#ifndef CategoryMacro_h
#define CategoryMacro_h

#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]/// rgb颜色转换（16进制->10进制）

#define kLabelTextColor kUIColorFromRGB(0x5BC1FF)
#define kTextFieldBgColor kUIColorFromRGB(0xffffff)
#define kTextfieldPlaceColor kUIColorFromRGB(0x313131)
#define kMain_color  kUIColorFromRGB(0x313131)
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kViewBgGradientImage [self createGradientColorWithRed:50.0/255 green:160.0/255 blue:200/255 startAlpha:0.8 endAlpha:0.2 direction:directionForDeviceStyleToUnBoard frame:CGRectMake((kScreenW - UIViewWidth) * 0.5, (kScreenH - UIViewHeight) * 0.5, UIViewWidth, UIViewHeight)];

#define UIViewHeight 255
#define UIViewWidth 310
#endif /* CategoryMacro_h */
