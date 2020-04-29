//
//  EDTSignatureViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTSignatureViewController.h"
@import Masonry;
@import EDTCommon;
@import EDTColor;
@import EDTString;

@interface EDTSignatureViewController ()

@property (nonatomic ,strong) UITextView *signaturetv;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) EDTSignatureBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) EDTSignatureBlock block;

@property (nonatomic ,strong) UITextView *placeholder;

@property (nonatomic ,strong) UIView *whiteView;

#if EDTNameOne


#elif EDTNameTwo

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif EDTNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif
@end

@implementation EDTSignatureViewController

+ (instancetype)createSignatureWithBlock:(EDTSignatureBlock)block {
    
    return [[self alloc] initWithBlock:block];
    
}
- (instancetype)initWithBlock:(EDTSignatureBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIView *)whiteView {
    
    if (!_whiteView) {
        
        _whiteView = [UIView new];
        
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UITextView *)signaturetv {
    
    if (!_signaturetv) {
        
        _signaturetv = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _signaturetv.font = EDTSYSTEMFONT(15);
        
        _signaturetv.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _signaturetv.tag = 201;
        
        _signaturetv.backgroundColor = [UIColor clearColor];
    }
    return _signaturetv;
}
- (UITextView *)placeholder {
    
    if (!_placeholder) {
        
        _placeholder = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _placeholder.font = EDTSYSTEMFONT(15);
        
        _placeholder.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _placeholder.tag = 202;
        
        _placeholder.backgroundColor = [UIColor whiteColor];
        
        _placeholder.userInteractionEnabled = false;
        
        _placeholder.text = @"请输入个性昵称";
        
        _placeholder.textColor = EDTColorCreate(@"#999999");
    }
    return _placeholder;
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
    
    [self.view addSubview:self.whiteView];
    
    [self.view addSubview:self.placeholder];
    
    [self.view addSubview:self.signaturetv];
    
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
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(120);
    }];
#elif EDTNameTwo
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.whiteView.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80"));
    
#elif EDTNameThree
    
    self.topLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(8);
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @EDTProjectColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")) forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"50")) forState:UIControlStateDisabled];
#endif
}

- (void)configNaviItem {
    
    self.title = @"修改个性签名";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
#if EDTNameTwo
    [self.backItem setImage:[UIImage imageNamed:@EDTLoginBackIcon] forState:UIControlStateNormal];
#endif
    
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
}

- (void)configViewModel {
    
    self.bridge = [EDTSignatureBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createSignature:self signatureAction:^(enum EDTSignatureActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
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
