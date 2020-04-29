//
//  FBSwiftLoginViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBSwiftLoginViewController.h"
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

@interface FBSwiftLoginViewController ()
@property (nonatomic ,strong) FBSwiftLoginBridge *bridge;

@property (nonatomic ,strong) FBLeftImageTextField *phone;

@property (nonatomic ,strong) FBVCodeImageTextField *vcode;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *proItem;

@property (nonatomic ,strong) UIButton *backLoginItem;

@property (nonatomic ,copy) FBSwiftLoginBlock block;
#if FBLoginOne

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

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

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else

#endif
@end

@implementation FBSwiftLoginViewController

+ (instancetype)createSwiftLoginWithBlock:(FBSwiftLoginBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(FBSwiftLoginBlock)block {
    
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

- (FBVCodeImageTextField *)vcode {
    
    if (!_vcode) {
        
        _vcode = [[FBVCodeImageTextField alloc] initWithFrame:CGRectZero];
        
        _vcode.tag = 202;
        
        _vcode.leftImageName = @FBVCodeIcon;
        
        _vcode.placeholder = @"请输入6位验证码";
        
        [_vcode FB_editType:FBTextFiledEditTypeVcode_length6];
        
        [_vcode FB_maxLength:6];
#if FBUPDATEVERSION
        _vcode.tintColor = FB_COLOR_CREATE(@FBProjectColor);
#endif
    }
    return _vcode;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = FB_BUTTON_NEW;
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
        
        [_loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _loginItem;
}

- (UIButton *)backLoginItem {
    
    if (!_backLoginItem) {
        
        _backLoginItem = FB_BUTTON_NEW;
        
        _backLoginItem.tag = 204;
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateNormal];
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateHighlighted];
        
        [_backLoginItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
        
        [_backLoginItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
        
        _backLoginItem.layer.masksToBounds = true;
        
        _backLoginItem.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
        
        _backLoginItem.layer.borderWidth = 1;
        
        _backLoginItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _backLoginItem;
}
- (UIButton *)proItem {
    
    if (!_proItem) {
        
        _proItem = FB_BUTTON_NEW;
        
        _proItem.tag = 205;
        
        NSMutableAttributedString *mutable = [NSMutableAttributedString new];
        
        NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                   NSForegroundColorAttributeName: FB_COLOR_CREATE(@FBProjectColor)}]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                         NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#333333")}] ];
        
       
        [_proItem setAttributedTitle:mutable forState:UIControlStateNormal];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                   NSForegroundColorAttributeName: FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) }]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                         NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#333333")}] ];
        
        [_proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
        
        _proItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _proItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.vcode];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.backLoginItem];
    
    [self.view addSubview:self.proItem];
    
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
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
#else
    
#endif
}

#if FBLoginOne
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
    }
    return _logoImgView;
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
        
        _drawView.fillColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"];
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
    
#if FBLoginOne
    
    self.title = @"注册/登陆";
    
#elif FBLoginTwo
    self.title = @"注册/登陆";
#elif FBLoginThree
    
    self.title = @"注册/登陆";
    
#elif FBLoginFour
    
    UILabel *titleLabel = FB_LABEL_NEW;
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"注册/登陆";
    
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
#else
    
#endif
}
- (void)configOwnSubViews {
    
#if FBLoginOne
    
    CGFloat w = FB_VIEWCONTROLLER_WIDTH;
    
    CGFloat h = w - 60;
    
    self.backgroundImageView.frame = self.view.bounds;
    
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
    
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    [self.vcode FB_bottomLineFrame:CGRectMake(0, 47, w - 60, 1)];
    
    [self.vcode FB_bottomLineColor:FB_COLOR_CREATE(@FBProjectColor)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#333333")}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#999999")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#333333", @"80")) }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#999999")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.loginItem.layer.cornerRadius = 3;
    
    self.loginItem.layer.masksToBounds = true;

    [self.loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];

    [self.loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:FB_COLOR_CREATE(@"#333333") forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#333333", @"80")) forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
#elif FBLoginTwo
    
    CGFloat w = FB_VIEWCONTROLLER_WIDTH;
    
    CGFloat h = w - 60;
    
    self.backgroundImageView.frame = self.view.bounds;
    
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
    
    [self.phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    //
    [self.phone FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    [self.vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#ffffff")}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#e1e1e1")}] ];
    [self.proItem setAttributFBitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#e1e1e1")}] ];
    [self.proItem setAttributFBitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
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
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-60);
        
        make.centerX.equalTo(self.view);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
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
    
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    self.vcode.layer.borderWidth = 1;
    
    self.vcode.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: FB_COLOR_CREATE(@FBProjectColor)}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#999999")}] ];
    [self.proItem setAttributFBitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#999999")}] ];
    [self.proItem setAttributFBitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
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
    
    [self.phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    //
    [self.phone FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    [self.vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:FB_COLOR_CREATE(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#ffffff")}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#e1e1e1")}] ];
    [self.proItem setAttributFBitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: FB_SYSTEM_FONT(12) ,
                                                                                                     NSForegroundColorAttributeName: FB_COLOR_CREATE(@"#e1e1e1")}] ];
    [self.proItem setAttributFBitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@FBProjectColor]] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
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
    
    self.bridge = [FBSwiftLoginBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createReg:self regAction:^(enum FBSwiftLoginActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
