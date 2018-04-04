//
//  JFButton.m
//  LoginButton
//
//  Created by 叶敬光 on 2017/5/5.
//  Copyright © 2017年 Bill. All rights reserved.
//  由于定义了一套按钮样式，所有JF的渐变色按钮都继承或实例化自这个类

#import "JFButton.h"

#import "UIColor+NotRGB.h"

@implementation JFButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.fontSize = 17.0f;
        self.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        
        
        
        
        // 设置圆角
        CALayer *buttonLayer = self.layer;
        [buttonLayer setMasksToBounds:YES];
        [buttonLayer setCornerRadius:self.frame.size.height / 2];
        
        
        // 初始化渐变图层
        [self setGradientLayer];
    }
    return self;
}

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title {
    JFButton *btn = [[self alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

#pragma mark - 初始化渐变图层
- (void)setGradientLayer {
    
    self.gradientLayer = [CAGradientLayer layer];
    // 设置左右渐变
    self.gradientLayer.startPoint = CGPointMake(0, .5);
    self.gradientLayer.endPoint = CGPointMake(1, .5);
    
    [self.gradientLayer setBounds:self.bounds];
    
    // 改变渐变图层的颜色
    NSArray *colors = [NSArray arrayWithObjects:
                       (id) [UIColor colorWithRed:233.0f / 255.0f green:99.0f / 255.0f blue:20.0f / 255.0f alpha:1].CGColor, // top
                       
                       (id) [UIColor colorWithRed:237.0f / 245.0f green:59.0f / 255.0f blue:60.0f / 255.0f alpha:1].CGColor, // bottom
                       nil];
    
    [self.gradientLayer setPosition:CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2)];
    [self.gradientLayer setColors:colors];
    [self.layer insertSublayer:self.gradientLayer atIndex:0];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setTintColor:[UIColor whiteColor]];
}

#pragma mark - 不可点击时的样式
- (void)disableGradientLayer {
    
    // 改变渐变图层的颜色
    NSArray *colors = [NSArray arrayWithObjects:
                       (id) [UIColor colorWithHexString:@"#f6c0a1" alpha:1.0f].CGColor, // top
                       
                       (id) [UIColor colorWithHexString:@"#f8b1b1" alpha:1.0f].CGColor, // bottom
                       nil];
    
    
    [self.gradientLayer setColors:colors];
    
    
    [self setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.6f] forState:UIControlStateNormal];
    //    [self setTintColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.6f]];
}

#pragma mark - 此按钮置灰，不能按
- (void)disable {
    
    if (self.enabled) {
        
        self.enabled = NO;
        [self disableGradientLayer];
    }
}

#pragma mark - 按下，放手
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        
        [self setNormalStyle];
    }
}

#pragma mark - 按下，未放手
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        
        // 改变渐变图层的颜色
        NSArray *colors = [NSArray arrayWithObjects:
                           (id) [UIColor colorWithHexString:@"#a3450e" alpha:1.0].CGColor, // top
                           
                           (id) [UIColor colorWithHexString:@"#a52a29" alpha:1.0].CGColor, // bottom
                           nil];
        
        [self.gradientLayer setColors:colors];
        
        // 因为“不可点击”状态下，文字alpha是0.6，所以每个状态都要把alpha置1，万无一失
        [self setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:1.0f] forState:UIControlStateNormal];
        
        
        //        [self start];
    }
    
}

#pragma mark - 恢复正常可点击状态的样式
- (void)setNormalStyle {
    
    // 改变渐变图层的颜色
    NSArray *colors = [NSArray arrayWithObjects:
                       (id) [UIColor colorWithHexString:@"#e96314" alpha:1.0].CGColor, // top
                       
                       (id) [UIColor colorWithHexString:@"#ed3b3c" alpha:1.0].CGColor, // bottom
                       nil];
    
    [self.gradientLayer setColors:colors];
    // 因为“不可点击”状态下，文字alpha是0.6，所以每个状态都要把alpha置1，万无一失
    [self setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:1.0f] forState:UIControlStateNormal];
}

//- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    NSLog(@"%@",event);
//    return YES;
//}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.selected = YES;
//}

@end
