//
//  FBLoginViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBLoginViewController.h"
@import FBTextField;
@import FBCommon;
@import FBColor;
@import FBImage;
@import FBString;
@import Masonry;

#if FBLoginTwo

@import FBDraw;

#elif FBLoginOne

@import FBDraw;

#endif

@interface FBLoginViewController ()

@property (nonatomic ,strong) FBLoginBridge *bridge;

@property (nonatomic ,strong) FBLeftImageTextField *phone;

@property (nonatomic ,strong) FBPasswordImageTextFiled *password;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UIButton *forgetItem;

@property (nonatomic ,strong) UIButton *swiftLoginItem;

#if FBLoginOne
@property (nonatomic ,strong) UIImageView *backgroundImageView;

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) FBDrawView *drawView;

#elif FBLoginTwo

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) FBDrawView *drawView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif FBLoginThree

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#elif FBLoginFour

@property (nonatomic ,strong) UIImageView *logoImgView;

#else

#endif

@property (nonatomic ,copy) FBLoginBlock block;
@end

@implementation FBLoginViewController

+ (instancetype)createLoginWithBlock:(FBLoginBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(FBLoginBlock)block  {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (FBLeftImageTextField *)phone {
    
    if (!_phone) {
        
        _phone = [[FBLeftImageTextField alloc] initWithFrame:CGRectZero];
        
        _phone.tag = 201;
        
        _phone.leftImageName = @FBPhoneIcon;
        
        _phone.placeholder = @"请输入11位手机号";
        
        [_phone FB_editType:FBTextFiledEditTypePhone];
        
        [_phone FB_maxLength:11];
        
#if FBUPDATEVERSION
        _phone.tintColor = FB_COLOR_CREATE(@FBProjectColor);
#endif
    }
    return _phone;
}

- (FBPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[FBPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.normalIcon = @FBPasswordNormalIcon;
        
        _password.selectedIcon = @FBPasswordSelectIcon;
        
        _password.leftImageName = @FBPasswordIcon;
        
        _password.placeholder = @"请输入6-18位密码";
        
        [_password FB_editType:FBTextFiledEditTypeSecret];
        
        [_password FB_maxLength:18];
#if FBUPDATEVERSION
        _password.tintColor = FB_COLOR_CREATE(@FBProjectColor);
#endif
    }
    return _password;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = FB_BUTTON_NEW;
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
    
        [_loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _loginItem;
}

- (UIButton *)swiftLoginItem {
    
    if (!_swiftLoginItem) {
        
        _swiftLoginItem = FB_BUTTON_NEW;
        
        _swiftLoginItem.tag = 204;
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateNormal];
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateHighlighted];
        
        [_swiftLoginItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
        
        [_swiftLoginItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
        
        _swiftLoginItem.layer.masksToBounds = true;
        
        _swiftLoginItem.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
        
        _swiftLoginItem.layer.borderWidth = 1;
        
        _swiftLoginItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _swiftLoginItem;
}
- (UIButton *)forgetItem {
    
    if (!_forgetItem) {
        
        _forgetItem = FB_BUTTON_NEW;
        
        _forgetItem.tag = 205;
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateNormal];
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateHighlighted];
        
        [_forgetItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
        
        [_forgetItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
        
        _forgetItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _forgetItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = FB_BUTTON_NEW;
    }
    return _backItem;
}
- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.swiftLoginItem];
    
    [self.view addSubview:self.forgetItem];
    
#if FBLoginOne
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self.view insertSubview:self.drawView atIndex:1];
    
    [self.view insertSubview:self.logoImgView atIndex:2];
    
#elif FBLoginTwo
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self.view insertSubview:self.drawView atIndex:1];
    
    [self.view insertSubview:self.logoImgView atIndex:2];
#elif FBLoginThree
    [self.view addSubview:self.logoImgView];
    
    [self.view addSubview:self.topLine];
    
    [self.view addSubview:self.bottomLine];
#elif FBLoginFour
    
    [self.view addSubview:self.logoImgView];
    
#else
    
#endif
}

#if FBLoginOne

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBLogoIcon]];
    }
    return _logoImgView;
}
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
- (FBDrawView *)drawView {
    
    if (!_drawView) {
        
        _drawView = [FBDrawView createDraw:FBDrawTypeShape];
        
        _drawView.backgroundColor = [UIColor clearColor];
        
        _drawView.fillColor = [UIColor clearColor];
    }
    return _drawView;
}
#elif FBLoginTwo

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}

- (FBDrawView *)drawView {
    
    if (!_drawView) {
        
        _drawView = [FBDrawView createDraw:FBDrawTypeShape];
        
        _drawView.backgroundColor = [UIColor clearColor];
        
        _drawView.fillColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"30"));
    }
    return _drawView;
}
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
#elif FBLoginThree

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 5;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
    }
    return _bottomLine;
}
#elif FBLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
#else

#endif
- (void)configNaviItem {
    
    [self.backItem setImage:[UIImage imageNamed:@FBLoginBackIcon] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
#if FBLoginOne
    
    self.title = @"登陆";
    
#elif FBLoginTwo
    
    self.title = @"登陆";
    
#elif FBLoginThree
    
    self.title = @"登陆";
    
#elif FBLoginFour
    
    UILabel *titleLabel = FB_LABEL_NEW;
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"登陆";
    
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
    
#else
    
#endif
    
#if ZForceLogin
    
    self.backItem.hidden = true;
#else
    
#endif
}

- (void)configOwnSubViews {
    
#if FBLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = FB_VIEWCONTROLLER_WIDTH;
    
    CGFloat h = w - 60;
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        
        make.right.mas_equalTo(-30);
        
        make.centerY.equalTo(self.view).offset(-30);
        
        make.height.mas_equalTo(h * 5 / 4);
    }];
    
    self.logoImgView.layer.cornerRadius = 40;
    
    self.logoImgView.layer.masksToBounds = true;
    
    self.logoImgView.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    self.logoImgView.layer.borderWidth = 1;
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.mas_equalTo(80);
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.top.mas_equalTo(FB_VIEWCONTROLLER_HEIGHT / 3 - FB_STATUSBAR_HEIGHT);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(30);
        
        make.left.mas_equalTo(30);
        
        make.right.mas_equalTo(-30);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    [self.phone FB_bottomLineFrame:CGRectMake(0, 47, w - 60, 1)];
    
    [self.phone FB_bottomLineColor:FB_COLOR_CREATE(@FBProjectColor)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    [self.password FB_bottomLineFrame:CGRectMake(0, 47, w - 60, 1)];
    
    [self.password FB_bottomLineColor:FB_COLOR_CREATE(@FBProjectColor)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:FB_COLOR_CREATE(@"#333333") forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#333333", @"80")) forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.loginItem.layer.cornerRadius = 3;
    
    self.loginItem.layer.masksToBounds = true;

    [self.loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];

    [self.loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:FB_COLOR_CREATE(@"#333333") forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#333333", @"80")) forState:UIControlStateHighlighted];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
#elif FBLoginTwo
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = FB_VIEWCONTROLLER_WIDTH;
    
    CGFloat h = w - 60;
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        
        make.right.mas_equalTo(-30);
        
        make.centerY.equalTo(self.view).offset(-30);
        
        make.height.mas_equalTo(h * 5 / 4);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.mas_equalTo(80);
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.centerY.equalTo(self.drawView.mas_top);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.drawView.mas_top).offset(60);
        
        make.left.equalTo(self.drawView.mas_left).offset(15);
        
        make.right.equalTo(self.drawView.mas_right).offset(-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    
    [self.phone FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.phone.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.loginItem setImage:[UIImage imageNamed:@FBLoginIcon] forState:UIControlStateNormal];
    
    [self.loginItem setImage:[UIImage imageNamed:@FBLoginIcon] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitle:@"" forState:UIControlStateNormal];

    [self.loginItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.loginItem.layer.cornerRadius = 40;
    
    self.loginItem.layer.masksToBounds = true;
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];

    [self.loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-60);
        
        make.centerX.equalTo(self.view);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
#elif FBLoginThree
    
    self.topLine.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    CGFloat w = FB_VIEWCONTROLLER_WIDTH;
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(8);
        
        make.top.mas_equalTo(h);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(25);
        
        make.width.height.mas_equalTo(@60);
    }];
    
    self.bottomLine.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(8);
        
        make.top.equalTo(self.logoImgView.mas_bottom).offset(25);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(15);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    
    self.phone.layer.borderWidth = 1;
    
    self.phone.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    self.password.layer.borderWidth = 1;
    
    self.password.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif FBLoginFour
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = FB_VIEWCONTROLLER_WIDTH;
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(60);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(60);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    
    [self.phone FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@FBProjectColor]] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.swiftLoginItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#else
    
    
#endif
    
    
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if FBLoginOne
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#elif FBLoginTwo
    
    self.view.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
#elif FBLoginThree
    
    self.view.backgroundColor = [UIColor whiteColor];
#elif FBLoginFour
    
    
#else
    
    
#endif
    
    
}
- (void)configViewModel {
    
    self.bridge = [FBLoginBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createLogin:self loginAction:^(enum FBLoginActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
    
}

@end
