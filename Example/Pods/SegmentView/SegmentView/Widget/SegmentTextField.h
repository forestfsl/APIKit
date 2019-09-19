//
//  SegmentTextField.h
//  RouterSDK
//
//  Created by fengsl on 2019/9/16.
//  Copyright © 2019 fengsl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SegmentTextField : UITextField


- (NSMutableAttributedString *)changePlaceholderWithTextField:(UITextField *)textField withString:(NSString *)string;

- (SegmentTextField *)createTextFieldWithtarget:(id)target placeholder:(id)placeholder;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
