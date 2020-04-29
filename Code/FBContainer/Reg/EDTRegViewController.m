//
//  EDTRegViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTRegViewController.h"
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

@interface EDTRegViewController ()
@property (nonatomic ,strong) EDTRegBridge *bridge;

@property (nonatomic ,strong) EDTLeftImageTextField *phone;

@property (nonatomic ,strong) EDTVCodeImageTextField *vcode;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *proItem;

@property (nonatomic ,strong) UIButton *backLoginItem;

@property (nonatomic ,copy) EDTRegBlock block;
#if EDTLoginOne

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

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

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else

#endif
@end

@implementation EDTRegViewController

+ (instancetype)createRegWithBlock:(EDTRegBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(EDTRegBlock)block {
    
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

- (EDTVCodeImageTextField *)vcode {
    
    if (!_vcode) {
        
        _vcode = [[EDTVCodeImageTextField alloc] initWithFrame:CGRectZero];
        
        _vcode.tag = 202;
        
        _vcode.leftImageName = @EDTVCodeIcon;
        
        _vcode.placeholder = @"请输入6位验证码";
        
        [_vcode EDT_editType:EDTTextFiledEditTypeVcode_length6];
        
        [_vcode EDT_maxLength:6];
#if EDTUPDATEVERSION
        _vcode.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _vcode;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
        
        [_loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _loginItem;
}

- (UIButton *)backLoginItem {
    
    if (!_backLoginItem) {
        
        _backLoginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _backLoginItem.tag = 204;
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateNormal];
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateHighlighted];
        
        [_backLoginItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
        
        [_backLoginItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
        
        _backLoginItem.layer.masksToBounds = true;
        
        _backLoginItem.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
        
        _backLoginItem.layer.borderWidth = 1;
        
        _backLoginItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _backLoginItem;
}
- (UIButton *)proItem {
    
    if (!_proItem) {
        
        _proItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _proItem.tag = 205;
        
        NSMutableAttributedString *mutable = [NSMutableAttributedString new];
        
        NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                   NSForegroundColorAttributeName: EDTColorCreate(@EDTProjectColor)}]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                         NSForegroundColorAttributeName: EDTColorCreate(@"#333333")}] ];
        [_proItem setAttributedTitle:mutable forState:UIControlStateNormal];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                   NSForegroundColorAttributeName: EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) }]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                         NSForegroundColorAttributeName: EDTColorCreate(@"#333333")}] ];
        
        [_proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
        
        _proItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _proItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.vcode];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.backLoginItem];
    
    [self.view addSubview:self.proItem];
    
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
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
#else
    
#endif
}

#if EDTLoginOne
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
    }
    return _logoImgView;
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
        
        _drawView.fillColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"];
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
    
#if EDTLoginOne
    
    self.title = @"注册/登陆";
    
#elif EDTLoginTwo
    self.title = @"注册/登陆";
#elif EDTLoginThree
    
    self.title = @"注册/登陆";
    
#elif EDTLoginFour
    
    UILabel *titleLabel = EDT_LABEL_NEW;
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"注册/登陆";
    
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
#else
    
#endif
}
- (void)configOwnSubViews {
    
#if EDTLoginOne
    
    CGFloat w = EDT_VIEWCONTROLLER_WIDTH;
    
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
    [self.phone EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
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
    
    [self.vcode EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:EDTColorCreate(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: EDTColorCreate(@"#333333")}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#999999")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#333333", @"80")) }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#999999")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
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
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-60);
        
        make.centerX.equalTo(self.view);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:EDTColorCreate(@"#333333") forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#333333", @"80")) forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
#elif EDTLoginTwo
    
    CGFloat w = EDT_VIEWCONTROLLER_WIDTH;
    
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
    [self.phone EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
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
    
    [self.vcode EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:EDTColorCreate(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: EDTColorCreate(@"#ffffff")}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#e1e1e1")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#e1e1e1")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
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
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-60);
        
        make.centerX.equalTo(self.view);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
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
    
    self.vcode.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:EDTColorCreate(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: EDTColorCreate(@EDTProjectColor)}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#999999")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#999999")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
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
    
    [self.phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    //
    [self.phone EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
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
    
    [self.vcode EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:EDTColorCreate(@"#999999") forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: EDTColorCreate(@"#ffffff")}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#e1e1e1")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: EDTSYSTEMFONT(12) ,
                                                                                                     NSForegroundColorAttributeName: EDTColorCreate(@"#e1e1e1")}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@EDTProjectColor]] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
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
    
    self.bridge = [EDTRegBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createReg:self regAction:^(enum EDTRegActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
