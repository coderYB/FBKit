//
//  EDTModifyPasswordViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTModifyPasswordViewController.h"
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

@interface EDTModifyPasswordViewController ()
@property (nonatomic ,strong) EDTModifyPasswordBridge *bridge;

@property (nonatomic ,strong) EDTPasswordImageTextFiled *oldpassword;

@property (nonatomic ,strong) EDTPasswordImageTextFiled *password;

@property (nonatomic ,strong) EDTPasswordImageTextFiled *againpassword;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) EDTModifyPasswordBlock block;

@property (nonatomic ,strong) UIButton *backItem;

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

@implementation EDTModifyPasswordViewController

+ (instancetype)createPasswordWithBlock:(EDTModifyPasswordBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(EDTModifyPasswordBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (EDTPasswordImageTextFiled *)oldpassword {
    
    if (!_oldpassword) {
        
        _oldpassword = [[EDTPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _oldpassword.tag = 201;
        
        _oldpassword.leftImageName = @EDTPasswordIcon;
        
        _oldpassword.placeholder = @"请输入6-18位旧密码";
        
        _oldpassword.normalIcon = @EDTPasswordNormalIcon;
        
        _oldpassword.selectedIcon = @EDTPasswordSelectIcon;
        
        _oldpassword.leftImageName = @EDTPasswordIcon;
        
        [_oldpassword EDT_editType:EDTTextFiledEditTypeSecret];
        
        [_oldpassword EDT_maxLength:18];
        
#if EDTUPDATEVERSION
        _oldpassword.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _oldpassword;
}
- (EDTPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[EDTPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.leftImageName = @EDTPasswordIcon;
        
        _password.placeholder = @"请输入6-18位新密码";
        
        _password.normalIcon = @EDTPasswordNormalIcon;
        
        _password.selectedIcon = @EDTPasswordSelectIcon;
        
        _password.leftImageName = @EDTPasswordIcon;
        
        [_password EDT_editType:EDTTextFiledEditTypeSecret];
        
        [_password EDT_maxLength:18];
        
#if EDTUPDATEVERSION
        _password.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _password;
}

- (EDTPasswordImageTextFiled *)againpassword {
    
    if (!_againpassword) {
        
        _againpassword = [[EDTPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _againpassword.tag = 203;
        
        _againpassword.leftImageName = @EDTPasswordIcon;
        
        _againpassword.placeholder = @"请输入6-18位确认密码";
        
        _againpassword.normalIcon = @EDTPasswordNormalIcon;
        
        _againpassword.selectedIcon = @EDTPasswordSelectIcon;
        
        _againpassword.leftImageName = @EDTPasswordIcon;
        
        [_againpassword EDT_editType:EDTTextFiledEditTypeSecret];
        
        [_againpassword EDT_maxLength:18];
        
#if EDTUPDATEVERSION
        _againpassword.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _againpassword;
}


- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 204;
        
        [_completeItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _completeItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backItem;
}


- (void)addOwnSubViews {
    
    [self.view addSubview:self.oldpassword];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.againpassword];
    
    [self.view addSubview:self.completeItem];
    
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
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.drawView.mas_top).offset(60);
        
        make.left.equalTo(self.drawView.mas_left).offset(15);
        
        make.right.equalTo(self.drawView.mas_right).offset(-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.masksToBounds = true;
    
    [self.oldpassword EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.cornerRadius = 24;
    
    self.againpassword.layer.masksToBounds = true;
    
    [self.againpassword EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.oldpassword.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.completeItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateNormal];
    
    [self.completeItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitle:@"" forState:UIControlStateNormal];

    [self.completeItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 40;
    
    self.completeItem.layer.masksToBounds = true;
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];

    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];;
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
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
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.drawView.mas_top).offset(60);
        
        make.left.equalTo(self.drawView.mas_left).offset(15);
        
        make.right.equalTo(self.drawView.mas_right).offset(-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.masksToBounds = true;
    
    [self.oldpassword EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.cornerRadius = 24;
    
    self.againpassword.layer.masksToBounds = true;
    
    [self.againpassword EDT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.oldpassword.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.completeItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateNormal];
    
    [self.completeItem setImage:[UIImage imageNamed:@EDTLoginIcon] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitle:@"" forState:UIControlStateNormal];

    [self.completeItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 40;
    
    self.completeItem.layer.masksToBounds = true;
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];

    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];;
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
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
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(15);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.cornerRadius = 24;
    
    self.oldpassword.layer.masksToBounds = true;
    
    self.oldpassword.layer.borderWidth = 1;
    
    self.oldpassword.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    self.password.layer.borderWidth = 1;
    
    self.password.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.cornerRadius = 24;
    
    self.againpassword.layer.masksToBounds = true;
    
    self.againpassword.layer.borderWidth = 1;
    
    self.againpassword.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.againpassword.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@EDTProjectColor]] forState:UIControlStateHighlighted];
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif EDTLoginFour
    
    
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
    
    self.bridge = [EDTModifyPasswordBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createPassword:self passwordAction:^{
        
        weakSelf.block(weakSelf ,EDTModifyPasswordActionTypeModify);
    }];
}
- (void)configNaviItem {
    
    if (self.navigationController.childViewControllers.count == 1) {
        
        [self.backItem setImage:[UIImage imageNamed:@EDTLoginBackIcon] forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
        
        [self.backItem addTarget:self action:@selector(EDTBackItemTap) forControlEvents:UIControlEventTouchUpInside];
    }
#if EDTLoginOne
    
    self.title = @"修改密码";
    
#elif EDTLoginTwo
    
    self.title = @"修改密码";
    
#elif EDTLoginThree
    
    self.title = @"修改密码";
    
#else
    
#endif
}

- (void)EDTBackItemTap {
    
    self.block(self, EDTModifyPasswordActionTypeBack);
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
