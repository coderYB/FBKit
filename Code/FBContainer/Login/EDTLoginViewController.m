//
//  EDTLoginViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTLoginViewController.h"
@import EDTTextField;
@import EDTCommon;
@import EDTColor;
@import EDTImage;
@import EDTString;
@import Masonry;

#if EDTLoginTwo

@import EDTDraw;

#elif EDTLoginOne

@import EDTDraw;

#endif

@interface EDTLoginViewController ()

@property (nonatomic ,strong) EDTLoginBridge *bridge;

@property (nonatomic ,strong) EDTLeftImageTextField *phone;

@property (nonatomic ,strong) EDTPasswordImageTextFiled *password;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UIButton *forgetItem;

@property (nonatomic ,strong) UIButton *swiftLoginItem;

#if EDTLoginOne
@property (nonatomic ,strong) UIImageView *backgroundImageView;

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) EDTDrawView *drawView;

#elif EDTLoginTwo

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) EDTDrawView *drawView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif EDTLoginThree

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#elif EDTLoginFour

@property (nonatomic ,strong) UIImageView *logoImgView;

#else

#endif

@property (nonatomic ,copy) EDTLoginBlock block;
@end

@implementation EDTLoginViewController

+ (instancetype)createLoginWithBlock:(EDTLoginBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(EDTLoginBlock)block  {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (EDTLeftImageTextField *)phone {
    
    if (!_phone) {
        
        _phone = [[EDTLeftImageTextField alloc] initWithFrame:CGRectZero];
        
        _phone.tag = 201;
        
        _phone.leftImageName = @EDTPhoneIcon;
        
        _phone.placeholder = @"请输入11位手机号";
        
        [_phone EDT_editType:EDTTextFiledEditTypePhone];
        
        [_phone EDT_maxLength:11];
        
#if EDTUPDATEVERSION
        _phone.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _phone;
}

- (EDTPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[EDTPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.normalIcon = @EDTPasswordNormalIcon;
        
        _password.selectedIcon = @EDTPasswordSelectIcon;
        
        _password.leftImageName = @EDTPasswordIcon;
        
        _password.placeholder = @"请输入6-18位密码";
        
        [_password EDT_editType:EDTTextFiledEditTypeSecret];
        
        [_password EDT_maxLength:18];
#if EDTUPDATEVERSION
        _password.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _password;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
    
        [_loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _loginItem;
}

- (UIButton *)swiftLoginItem {
    
    if (!_swiftLoginItem) {
        
        _swiftLoginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _swiftLoginItem.tag = 204;
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateNormal];
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateHighlighted];
        
        [_swiftLoginItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
        
        [_swiftLoginItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
        
        _swiftLoginItem.layer.masksToBounds = true;
        
        _swiftLoginItem.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
        
        _swiftLoginItem.layer.borderWidth = 1;
        
        _swiftLoginItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _swiftLoginItem;
}
- (UIButton *)forgetItem {
    
    if (!_forgetItem) {
        
        _forgetItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _forgetItem.tag = 205;
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateNormal];
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateHighlighted];
        
        [_forgetItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
        
        [_forgetItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
        
        _forgetItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _forgetItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backItem;
}
- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.swiftLoginItem];
    
    [self.view addSubview:self.forgetItem];
    
#if EDTLoginOne
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self.view insertSubview:self.drawView atIndex:1];
    
    [self.view insertSubview:self.logoImgView atIndex:2];
    
#elif EDTLoginTwo
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self.view insertSubview:self.drawView atIndex:1];
    
    [self.view insertSubview:self.logoImgView atIndex:2];
#elif EDTLoginThree
    [self.view addSubview:self.logoImgView];
    
    [self.view addSubview:self.topLine];
    
    [self.view addSubview:self.bottomLine];
#elif EDTLoginFour
    
    [self.view addSubview:self.logoImgView];
    
#else
    
#endif
}

#if EDTLoginOne

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTLogoIcon]];
    }
    return _logoImgView;
}
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
- (EDTDrawView *)drawView {
    
    if (!_drawView) {
        
        _drawView = [EDTDrawView createDraw:EDTDrawTypeShape];
        
        _drawView.backgroundColor = [UIColor clearColor];
        
        _drawView.fillColor = EDTColorCreate(@"#bdc5ce");
    }
    return _drawView;
}
#elif EDTLoginTwo

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}

- (EDTDrawView *)drawView {
    
    if (!_drawView) {
        
        _drawView = [EDTDrawView createDraw:EDTDrawTypeShape];
        
        _drawView.backgroundColor = [UIColor clearColor];
        
        _drawView.fillColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"30"));
    }
    return _drawView;
}
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
#elif EDTLoginThree

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 5;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
        
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
#elif EDTLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
#else

#endif
- (void)configNaviItem {
    
    [self.backItem setImage:[UIImage imageNamed:@EDTLoginBackIcon] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
#if EDTLoginOne
    
    self.title = @"登陆";
    
#elif EDTLoginTwo
    
    self.title = @"登陆";
    
#elif EDTLoginThree
    
    self.title = @"登陆";
    
#elif EDTLoginFour
    
    UILabel *titleLabel = EDT_LABEL_NEW;
    
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
    
#if EDTLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = EDT_VIEWCONTROLLER_WIDTH;
    
    CGFloat h = w - 60;
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        
        make.right.mas_equalTo(-30);
        
        make.centerY.equalTo(self.view).offset(-30);
        
        make.height.mas_equalTo(h * 5 / 4);
    }];
    
    self.logoImgView.layer.cornerRadius = 40;
    
    self.logoImgView.layer.masksToBounds = true;
    
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
    
    [self.phone EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:EDTColorCreate(@"#333333") forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#333333", @"80")) forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.phone.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.loginItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateNormal];
    
    [self.loginItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitle:@"" forState:UIControlStateNormal];

    [self.loginItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.loginItem.layer.cornerRadius = 40;
    
    self.loginItem.layer.masksToBounds = true;
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];

    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-60);
        
        make.centerX.equalTo(self.view);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:EDTColorCreate(@"#333333") forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#333333", @"80")) forState:UIControlStateHighlighted];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
#elif EDTLoginTwo
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = EDT_VIEWCONTROLLER_WIDTH;
    
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
    
    [self.phone EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.phone.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.loginItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateNormal];
    
    [self.loginItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitle:@"" forState:UIControlStateNormal];

    [self.loginItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.loginItem.layer.cornerRadius = 40;
    
    self.loginItem.layer.masksToBounds = true;
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];

    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-60);
        
        make.centerX.equalTo(self.view);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
#elif EDTLoginThree
    
    self.topLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    CGFloat w = EDT_VIEWCONTROLLER_WIDTH;
    
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
    
    self.bottomLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
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
    
    self.phone.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
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
    
    self.password.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif EDTLoginFour
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = EDT_VIEWCONTROLLER_WIDTH;
    
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
    
    [self.phone EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@EDTProjectColor]] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.swiftLoginItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#else
    
    
#endif
    
    
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if EDTLoginOne
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#elif EDTLoginTwo
    
    self.view.backgroundColor = EDTColorCreate(@EDTProjectColor);
#elif EDTLoginThree
    
    self.view.backgroundColor = [UIColor whiteColor];
#elif EDTLoginFour
    
    
#else
    
    
#endif
    
    
}
- (void)configViewModel {
    
    self.bridge = [EDTLoginBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createLogin:self loginAction:^(enum EDTLoginActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
    
}

@end
