//
//  FBModifyPasswordViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBModifyPasswordViewController.h"
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

@interface FBModifyPasswordViewController ()
@property (nonatomic ,strong) FBModifyPasswordBridge *bridge;

@property (nonatomic ,strong) FBPasswordImageTextFiled *oldpassword;

@property (nonatomic ,strong) FBPasswordImageTextFiled *password;

@property (nonatomic ,strong) FBPasswordImageTextFiled *againpassword;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) FBModifyPasswordBlock block;

@property (nonatomic ,strong) UIButton *backItem;

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

@implementation FBModifyPasswordViewController

+ (instancetype)createPasswordWithBlock:(FBModifyPasswordBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(FBModifyPasswordBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (FBPasswordImageTextFiled *)oldpassword {
    
    if (!_oldpassword) {
        
        _oldpassword = [[FBPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _oldpassword.tag = 201;
        
        _oldpassword.leftImageName = @FBPasswordIcon;
        
        _oldpassword.placeholder = @"请输入6-18位旧密码";
        
        _oldpassword.normalIcon = @FBPasswordNormalIcon;
        
        _oldpassword.selectedIcon = @FBPasswordSelectIcon;
        
        _oldpassword.leftImageName = @FBPasswordIcon;
        
        [_oldpassword FB_editType:FBTextFiledEditTypeSecret];
        
        [_oldpassword FB_maxLength:18];
        
#if FBUPDATEVERSION
        _oldpassword.tintColor = FB_COLOR_CREATE(@FBProjectColor);
#endif
    }
    return _oldpassword;
}
- (FBPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[FBPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.leftImageName = @FBPasswordIcon;
        
        _password.placeholder = @"请输入6-18位新密码";
        
        _password.normalIcon = @FBPasswordNormalIcon;
        
        _password.selectedIcon = @FBPasswordSelectIcon;
        
        _password.leftImageName = @FBPasswordIcon;
        
        [_password FB_editType:FBTextFiledEditTypeSecret];
        
        [_password FB_maxLength:18];
        
#if FBUPDATEVERSION
        _password.tintColor = FB_COLOR_CREATE(@FBProjectColor);
#endif
    }
    return _password;
}

- (FBPasswordImageTextFiled *)againpassword {
    
    if (!_againpassword) {
        
        _againpassword = [[FBPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _againpassword.tag = 203;
        
        _againpassword.leftImageName = @FBPasswordIcon;
        
        _againpassword.placeholder = @"请输入6-18位确认密码";
        
        _againpassword.normalIcon = @FBPasswordNormalIcon;
        
        _againpassword.selectedIcon = @FBPasswordSelectIcon;
        
        _againpassword.leftImageName = @FBPasswordIcon;
        
        [_againpassword FB_editType:FBTextFiledEditTypeSecret];
        
        [_againpassword FB_maxLength:18];
        
#if FBUPDATEVERSION
        _againpassword.tintColor = FB_COLOR_CREATE(@FBProjectColor);
#endif
    }
    return _againpassword;
}


- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = FB_BUTTON_NEW;
        
        _completeItem.tag = 204;
        
        [_completeItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _completeItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = FB_BUTTON_NEW;
    }
    return _backItem;
}


- (void)addOwnSubViews {
    
    [self.view addSubview:self.oldpassword];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.againpassword];
    
    [self.view addSubview:self.completeItem];
    
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
    
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.drawView.mas_top).offset(60);
        
        make.left.equalTo(self.drawView.mas_left).offset(15);
        
        make.right.equalTo(self.drawView.mas_right).offset(-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    [self.oldpassword FB_bottomLineFrame:CGRectMake(0, 47, w - 60, 1)];
    
    [self.oldpassword FB_bottomLineColor:FB_COLOR_CREATE(@FBProjectColor)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    [self.password FB_bottomLineFrame:CGRectMake(0, 47, w - 60, 1)];
    
    [self.password FB_bottomLineColor:FB_COLOR_CREATE(@FBProjectColor)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    [self.againpassword FB_bottomLineFrame:CGRectMake(0, 47, w - 60, 1)];
    
    [self.againpassword FB_bottomLineColor:FB_COLOR_CREATE(@FBProjectColor)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.oldpassword.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.completeItem.layer.cornerRadius = 3;
    
    self.completeItem.layer.masksToBounds = true;
    
    [self.completeItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];

    [self.completeItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
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
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.drawView.mas_top).offset(60);
        
        make.left.equalTo(self.drawView.mas_left).offset(15);
        
        make.right.equalTo(self.drawView.mas_right).offset(-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.masksToBounds = true;
    
    [self.oldpassword FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.cornerRadius = 24;
    
    self.againpassword.layer.masksToBounds = true;
    
    [self.againpassword FB_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.oldpassword.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.completeItem setImage:[UIImage imageNamed:@FBLoginIcon] forState:UIControlStateNormal];
    
    [self.completeItem setImage:[UIImage imageNamed:@FBLoginIcon] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitle:@"" forState:UIControlStateNormal];

    [self.completeItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 40;
    
    self.completeItem.layer.masksToBounds = true;
    
    [self.completeItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];

    [self.completeItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];;
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
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
    
    self.oldpassword.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
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
    
    self.password.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
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
    
    self.againpassword.layer.borderColor = FB_COLOR_CREATE(@FBProjectColor).CGColor;
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.againpassword.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage FBTransformFromHexValue:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@"#ffffff", @"80")] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@FBProjectColor]] forState:UIControlStateHighlighted];
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif FBLoginFour
    
    
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
    
    self.bridge = [FBModifyPasswordBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createPassword:self passwordAction:^{
        
        weakSelf.block(weakSelf ,FBModifyPasswordActionTypeModify);
    }];
}
- (void)configNaviItem {
    
    if (self.navigationController.childViewControllers.count == 1) {
        
        [self.backItem setImage:[UIImage imageNamed:@FBLoginBackIcon] forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
        
        [self.backItem addTarget:self action:@selector(FBBackItemTap) forControlEvents:UIControlEventTouchUpInside];
    }
#if FBLoginOne
    
    self.title = @"修改密码";
    
#elif FBLoginTwo
    
    self.title = @"修改密码";
    
#elif FBLoginThree
    
    self.title = @"修改密码";
    
#else
    
#endif
}

- (void)FBBackItemTap {
    
    self.block(self, FBModifyPasswordActionTypeBack);
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
