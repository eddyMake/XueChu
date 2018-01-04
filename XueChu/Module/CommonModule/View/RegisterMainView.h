//
//  RegisterMainView.h
//  XueChu
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "BaseView.h"
#import "PhoneCapchaButton.h"

@interface RegisterMainView : BaseView

@property (nonatomic, strong) UITextField *accountTf;
@property (nonatomic, strong) UITextField *passwordTf;
@property (nonatomic, strong) UITextField *codeTf;

@property (nonatomic, strong) PhoneCapchaButton *capchaBtn;

@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *agreeBtn;

@end
