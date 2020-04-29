//
//  FBNameViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBNameViewController.h"
@import Masonry;
@import FBCommon;
@import FBColor;
@import FBString;
@import FBTextField;

@interface FBNameViewController ()

@property (nonatomic ,strong) FBNickNameTextField *textField;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) FBNameBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) FBNameBlock block;

#if FBNameOne


#elif FBNameTwo

@property (nonatomic ,strong) UIImageView *backgroundImageView;

//    self.view.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);

#elif FBNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif

@end

@implementation FBNameViewController

+ (instancetype)createNickNameWithBlock:(FBNameBlock)block {
    
    return [[self alloc] initWithBlock:block];
    
}
- (instancetype)initWithBlock:(FBNameBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
#if FBNameOne


#elif FBNameTwo

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
    }
    return _backgroundImageView;
}

#elif FBNameThree

- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#endif

- (FBNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[FBNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField FB_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField FB_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 201;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入昵称";
    }
    return _textField;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = FB_BUTTON_NEW;
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
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
    
    [self.view addSubview:self.textField];
    
#if FBNameOne
    
    [self.completeItem setTitleColor:FB_COLOR_CREATE(@FBProjectColor) forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];

    [self.completeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"50")) forState:UIControlStateDisabled];
    
#elif FBNameTwo
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
#elif FBNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
    
    
#if FBNameOne
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 1);
        
        make.height.mas_equalTo(48);
    }];
#elif FBNameTwo
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(48);
    }];
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.textField.backgroundColor = FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@"#ffffff", @"80"));
    
#elif FBNameThree
    
    self.topLine.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(8);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(48);
    }];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @FBProjectColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:FB_ALPHA_COLOR_CREATE(FB_COLOR_FORMAT_STRING(@FBProjectColor, @"50")) forState:UIControlStateDisabled];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"修改昵称";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
#if FBNameTwo
    [self.backItem setImage:[UIImage imageNamed:@FBLoginBackIcon] forState:UIControlStateNormal];
#endif
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
}
- (void)configViewModel {
    
    self.bridge = [FBNameBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createName:self nameAction:^(enum FBNameActionType actionType) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf ;
        
        strongSelf.block(actionType, strongSelf);
    }];
}
- (void)configOwnProperties {
    
#if FBNameOne
    [super configOwnProperties];
    
#elif FBNameTwo
    [super configOwnProperties];
#elif FBNameThree
    [super configOwnProperties];
#endif
    
    
}
@end
