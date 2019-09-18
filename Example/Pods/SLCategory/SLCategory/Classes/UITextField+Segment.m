
#import "UITextField+Segment.h"
#import "CategoryMacro.h"


@implementation UITextField (Segment)

+ (UITextField *)createTFWithPlaceholder:(NSString *)placeholder leftImage:(UIImage *)image{
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = placeholder;
    [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [textField setValue:kTextfieldPlaceColor forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView *userNameHintView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    UIImageView *userNameImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 24, 24)];
    userNameImageV.layer.masksToBounds = YES;
    userNameImageV.layer.cornerRadius = 12;
    userNameImageV.image = image;
    userNameImageV.userInteractionEnabled = YES;
    [userNameHintView addSubview:userNameImageV];
    textField.backgroundColor = kTextFieldBgColor;
    textField.leftView = userNameHintView;
    
    
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
    
}

+ (UITextField *)createHintTextForLeftLabel:(NSString *)hintText placeholder:(NSString *)placeholder{
    UITextField *textField = [[UITextField alloc]init];
     textField.placeholder = placeholder;
    [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [textField setValue:kTextfieldPlaceColor forKeyPath:@"_placeholderLabel.textColor"];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 10;
    if (hintText.length > 0) {
        UIView *userNameHintView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        UILabel *userNameHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 44)];
        userNameHintLabel.text = hintText;
        userNameHintLabel.textColor = kMain_color;
        [userNameHintLabel setFont:[UIFont systemFontOfSize:15]];
        
        [userNameHintView addSubview:userNameHintLabel];
        textField.leftView = userNameHintView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
   
    
   
    
    return textField;
}

@end
