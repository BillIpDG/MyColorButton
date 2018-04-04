//
//  LoginButton.h
//  LoginButton
//
//  Created by 叶敬光 on 2017/5/4.
//  Copyright © 2017年 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFButton.h"

@interface LoginButton : JFButton


+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title loadingTitle:(NSString *)loadingTitle;

/** 此方法在addTarget触发时调用 */
- (void)start;
/** 获得返回数据时调用，停止转圈动画，并回复按钮未点击时的样式。也可作为恢复正常状态之用 */
- (void)stop;


@end
