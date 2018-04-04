//
//  UIColor+NotRGB.h
//  LoginButton
//
//  Created by 叶敬光 on 2017/5/5.
//  Copyright © 2017年 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NotRGB)
//+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

/**
 *  16进制转uicolor
 *
 *  @param color @"#FFFFFF" ,@"OXFFFFFF" ,@"FFFFFF"
 *
 *  @return uicolor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
