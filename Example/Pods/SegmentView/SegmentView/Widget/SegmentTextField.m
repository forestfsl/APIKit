//
//  SegmentTextField.m
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import "SegmentTextField.h"
#import "SegmentConfigMacro.h"

@implementation SegmentTextField

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.layer.borderColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.8627 alpha:1.0].CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = kTextFieldBgColor;
        self.textColor = kLabelTextColor;
    }
    return self;
}

- (NSMutableAttributedString *)changePlaceholderWithTextField:(UITextField *)textField withString:(NSString *)string{
    //设置光标颜色
    //    textField.tintColor = UIColorFromRGB(0xF87A00);
    //    textField.textColor = UIColorFromRGB(0xF87A00);
    textField.layer.borderColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.8627 alpha:1.0].CGColor;
    textField.layer.borderWidth = 1;
    textField.backgroundColor = kTextFieldBgColor;
    textField.textColor = kLabelTextColor;
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 5;
    //placeholder前面加入空格
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 42/2/1.5, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    if (kScreenW == 320) {
        
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, string.length)];
    }else{
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, string.length)];
    }
    //设置placeholder字体的颜色
    [attributeString addAttribute:NSForegroundColorAttributeName value:kTextfieldPlaceColor range:NSMakeRange(0, string.length)];
    return attributeString;
}

- (SegmentTextField *)createTextFieldWithtarget:(id)target placeholder:(id)placeholder{
    SegmentTextField *textfield = [[SegmentTextField alloc]init];
    textfield.attributedPlaceholder = [self changePlaceholderWithTextField:textfield withString:placeholder];
    textfield.layer.masksToBounds = YES;
    textfield.layer.borderColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.8627 alpha:1.0].CGColor;;
    textfield.layer.borderWidth = 1;
    textfield.delegate = target;
    [textfield setFont:[UIFont systemFontOfSize:12.0]];
    textfield.backgroundColor = kTextFieldBgColor;
    return textfield;
}

@end
