//
//  SelectBirthdayController.m
//  XueChu
//
//  Created by eddy on 2018/1/4.
//  Copyright © 2018年 eddy. All rights reserved.
//

#import "SelectBirthdayController.h"
#import "SelectAddressController.h"

@interface SelectBirthdayController ()

@property (nonatomic, strong) NSMutableArray *sexBtnArray;

@end

@implementation SelectBirthdayController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sexBtnArray = [NSMutableArray arrayWithCapacity:2];
    
    [self setUpUserInterface];
}

#pragma mark - ******** UI

- (void)setUpUserInterface
{
    UILabel *oneLb = [self commonLabelWithFont:25 textColor:[UIColor fontBlackColor] text:@"让我了解你"];
    UILabel *twoLb = [self commonLabelWithFont:16 textColor:[UIColor fontGrayColor] text:@"为你发现更合适的商品"];
    
    [oneLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(XSScreenScaleY(90));
        make.left.right.equalTo(self.view);
    }];
    
    [twoLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneLb.bottom).offset(16);
        make.left.right.equalTo(self.view);
    }];
    
    UIButton *manBtn = [self commonButtonWithNormalImageName:@"ic_female" selectImageName:@"ic_female_z" title:@"男"];
    UIButton *womanBtn = [self commonButtonWithNormalImageName:@"ic_female_c" selectImageName:@"ic_female_v" title:@"女"];
    
    [manBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoLb.bottom).offset(34);
        make.right.equalTo(self.view).offset(-XSScreenScaleX(80));
    }];
    
    [womanBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(manBtn);
        make.left.equalTo(self.view).offset(XSScreenScaleX(80));
    }];
    
    [manBtn layoutIfNeeded];
    [manBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:10];
    
    [womanBtn setSelected:YES];
    [womanBtn layoutIfNeeded];
    [womanBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:10];
    
    UILabel *threeLb = [self commonLabelWithFont:25 textColor:[UIColor fontBlackColor] text:@"你的出生年年月日"];
    UILabel *fourLb = [self commonLabelWithFont:16 textColor:[UIColor fontGrayColor] text:@"仅用作个性化推荐，学厨会帮你保密"];
    
    [threeLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(manBtn.bottom).offset(XSScreenScaleY(80));
        make.left.right.equalTo(self.view);
    }];
    
    [fourLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(threeLb.bottom).offset(17);
        make.left.right.equalTo(self.view);
    }];
    
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [continueBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [continueBtn setTitle:@"选好了，继续" forState:UIControlStateNormal];
    [continueBtn setBackgroundColor:[UIColor normalButtonColor]];
    [continueBtn.layer setCornerRadius:21];
    [continueBtn.layer setMasksToBounds:YES];
    [continueBtn addTarget:self action:@selector(continueBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:continueBtn];
    [continueBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(203, 42));
        make.bottom.equalTo(self.view).offset(-XSScreenScaleY(80));
    }];
}

- (UILabel *)commonLabelWithFont:(CGFloat)fontSize textColor:(UIColor *)textColor text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:fontSize]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:textColor];
    [label setText:text];
    
    [self.view addSubview:label];
    
    return label;
}

- (UIButton *)commonButtonWithNormalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor fontDarkBlackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor fontBlackColor] forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    [_sexBtnArray addObject:btn];
    
    return btn;
}

#pragma mark - ********* 事件

- (void)sexBtnClick:(UIButton *)sender
{
    for (UIButton *btn in _sexBtnArray)
    {
        [btn setSelected:NO];
    }
    
    [sender setSelected:YES];
    
    if ([sender.titleLabel.text rangeOfString:@"男"].location != NSNotFound)
    {
        
    }
    else
    {
        
    }
}

- (void)continueBtn:(UIButton *)sender
{
    SelectAddressController *ctl = [[SelectAddressController alloc] init];
    
    [self presentViewController:ctl animated:YES completion:nil];
}

- (BOOL)isShowNavigationBar
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
