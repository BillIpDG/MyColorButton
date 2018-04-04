//
//  JFButton.h
//  LoginButton
//
//  Created by 叶敬光 on 2017/5/5.
//  Copyright © 2017年 Bill. All rights reserved.
//  由于定义了一套按钮样式，所有JF的渐变色按钮都继承或实例化自这个类

#import <UIKit/UIKit.h>

@interface JFButton : UIButton

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title;

/** 字体大小 */
@property (nonatomic, assign) CGFloat fontSize;
/** 本按钮的渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


/** 把按钮置为不可点击状态 */
- (void)disable;
/** 恢复正常可点击状态的样式 */
- (void)setNormalStyle;

@end
