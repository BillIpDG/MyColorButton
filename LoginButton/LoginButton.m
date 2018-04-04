//
//  LoginButton.m
//  LoginButton
//
//  Created by 叶敬光 on 2017/5/4.
//  Copyright © 2017年 Bill. All rights reserved.
//

#import "LoginButton.h"
#import "Masonry.h"

@interface LoginButton ()

/** 转圈 */
@property (nonatomic, strong) UIImageView *waitingImageView;


/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;

/** label的x坐标 */
@property (nonatomic, assign) CGFloat normalX;

/** label的x坐标 */
@property (nonatomic, assign) CGFloat pressedX;
/** label的x坐标 */
@property (nonatomic, assign) CGFloat currentX;

/** 转圈的x坐标 */
@property (nonatomic, assign) CGFloat imageViewX;

/** 为了获得label的宽度，必须在layoutSubviews里做一次，并且仅做一次 */
@property (nonatomic, assign) BOOL oneTime;

/** 正常状态下的titl */
@property (nonatomic, copy) NSString *title;

/** loading状态下的title，loading时的title */
@property (nonatomic, copy) NSString *loadingTitle;

@end

@implementation LoginButton


+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title loadingTitle:(NSString *)loadingTitle{
    
    LoginButton *btn = [LoginButton buttonWithFrame:frame title:title];
    btn.title = title;
    btn.loadingTitle = loadingTitle;
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.oneTime = NO;
        
        self.waitingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 22, 22)];
        self.waitingImageView.image = [UIImage imageNamed:@"icon_waiting"];
        
        [self addSubview:self.waitingImageView];
        self.waitingImageView.hidden = YES;

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 只做一次，只为了获得 title 的 label 宽度
    if (!self.oneTime) {
        self.oneTime = YES;
        
        [self setTitle:self.loadingTitle forState:UIControlStateNormal];
        
        CGFloat space = 13;
        CGFloat imageWidth = 22;
        
        CGFloat titleWidth = self.titleLabel.frame.size.width;
        
        CGFloat totalWidth = imageWidth + space + titleWidth;
        self.imageViewX = (self.frame.size.width - totalWidth)/2;
        
        self.pressedX = self.imageViewX + imageWidth + space;
        [self setTitle:self.title forState:UIControlStateNormal];
        [self setTitle:self.title forState:UIControlStateHighlighted];
        self.normalX = (self.frame.size.width - self.titleLabel.frame.size.width)/2;
        self.currentX = self.normalX;
    }
    
    [self.waitingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(self.imageViewX);
    }];
    
    self.titleLabel.frame = CGRectMake(self.currentX, self.titleLabel.frame.origin.y,  self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    // ---
    
}

#pragma mark - 初始化转圈动画，每次放手时都初始化一次
- (void)initAnimation {
    
    
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    // 何时开始执行第一个任务
    // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
    dispatch_time_t start = 0;//dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(0.1 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
//        NSLog(@"------------%@", [NSThread currentThread]);
        CGAffineTransform trans2 = CGAffineTransformRotate(self.waitingImageView.transform, 45.0 / 180.0 * M_PI);
        self.waitingImageView.transform = trans2;
    });
    
    
}



#pragma mark - 此按钮置灰，不能按
- (void)disable {
    
    if (self.enabled) {
        
        [self stop];
    }
    [super disable];
}


#pragma mark - 点击放手后( Highlighted 之后)，开始转圈动画
- (void)start {
    
    // 启动定时器
    if (self.timer == nil) {
        [self initAnimation];
        dispatch_resume(self.timer);
    }
    
    
    self.enabled = NO;
    self.selected = YES;
    
    // 改变label的x坐标
    self.currentX = self.pressedX;
    
    [self setTitle:self.loadingTitle forState:UIControlStateNormal];
    
    
    self.waitingImageView.hidden = NO;
    
    
}


#pragma mark - 加载完毕后，取消动画
- (void)stop {
    // 取消定时器
    if (self.timer != nil) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    self.selected = NO;
    self.enabled = YES;
    // 改变label的x坐标
    self.currentX = self.normalX;
    
    [self setTitle:self.title forState:UIControlStateNormal];
    
    [self setNormalStyle];
    self.waitingImageView.hidden = YES;
}

@end
