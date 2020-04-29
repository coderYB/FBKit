//
//  EDTNameViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTNameViewController.h"
@import Masonry;
@import EDTCommon;
@import EDTColor;
@import EDTString;
@import EDTTextField;

@interface EDTNameViewController ()

@property (nonatomic ,strong) EDTNickNameTextField *textField;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) EDTNameBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) EDTNameBlock block;

#if EDTNameOne


#elif EDTNameTwo

@property (nonatomic ,strong) UIImageView *backgroundImageView;

//    self.view.backgroundColor = EDTColorCreate(@EDTProjectColor);

#elif EDTNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif

@end

@implementation EDTNameViewController

+ (instancetype)createNickNameWithBlock:(EDTNameBlock)block {
    
    return [[self alloc] initWithBlock:block];
    
}
- (instancetype)initWithBlock:(EDTNameBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
#if EDTNameOne


#elif EDTNameTwo

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
    }
    return _backgroundImageView;
}

#elif EDTNameThree

- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#endif

- (EDTNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[EDTNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField EDT_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField EDT_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 201;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入昵称";
    }
    return _textField;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
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
    
    [self.view addSubview:self.textField];
    
#if EDTNameOne
    
    [self.completeItem setTitleColor:EDTColorCreate(@EDTProjectColor) forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];

    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"50")) forState:UIControlStateDisabled];
    
#elif EDTNameTwo
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
#elif EDTNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
    
    
#if EDTNameOne
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 1);
        
        make.height.mas_equalTo(48);
    }];
#elif EDTNameTwo
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(48);
    }];
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.textField.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80"));
    
#elif EDTNameThree
    
    self.topLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
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
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @EDTProjectColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"50")) forState:UIControlStateDisabled];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"修改昵称";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
#if EDTNameTwo
    [self.backItem setImage:[UIImage imageNamed:@EDTLoginBackIcon] forState:UIControlStateNormal];
#endif
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
}
- (void)configViewModel {
    
    self.bridge = [EDTNameBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createName:self nameAction:^(enum EDTNameActionType actionType) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf ;
        
        strongSelf.block(actionType, strongSelf);
    }];
}
- (void)configOwnProperties {
    
#if EDTNameOne
    [super configOwnProperties];
    
#elif EDTNameTwo
    [super configOwnProperties];
#elif EDTNameThree
    [super configOwnProperties];
#endif
    
    
}
@end
