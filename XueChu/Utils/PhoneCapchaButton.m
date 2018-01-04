//
//  PhoneCapchaButton.m
//  XueChu
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "PhoneCapchaButton.h"
#import "NSTimer+BlockSupport.h"

@interface PhoneCapchaButton ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval validityDuration;

@end

@implementation PhoneCapchaButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [self setEnabled:NO];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:4.0f];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setBackgroundImage:createImageWithColor([UIColor enableButtonColor]) forState:UIControlStateDisabled];
    [self setBackgroundImage:createImageWithColor([UIColor mainColor]) forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (enabled)
    {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else if ([self.titleLabel.text isEqualToString:@""])
    {
        [self setTitle:@"正在发送..." forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.enabled = self.isEnabled;
}

#pragma mark - ********* 事件

- (void)startTimer
{
    _validityDuration = 60;
    
    self.enabled = !self.isEnabled;
    
    [self setTitle:[NSString stringWithFormat:@"重新发送(%.0f)", _validityDuration] forState:UIControlStateNormal];
    
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer bs_scheduledTimerWithTimeInterval:1 block:^{
        PhoneCapchaButton *strongSelf = weakSelf;
        [strongSelf redrawTimer];
    } repeats:YES];
    
}

- (void)invalidateTimer
{
    self.enabled = !self.isEnabled;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)redrawTimer
{
    _validityDuration--;
    
    if (_validityDuration > 0)
    {
        [self setTitle:[NSString stringWithFormat:@"重新发送(%.0f)", _validityDuration] forState:UIControlStateNormal];
    }
    else
    {
        [self invalidateTimer];
    }
}

@end
