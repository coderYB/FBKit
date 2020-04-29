//
//  EDTFeedBackViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTFeedBackViewController.h"
@import Masonry;
@import EDTTextField;
@import JXTAlertManager;
@import EDTColor;
@import EDTCommon;
@import EDTImage;
@import EDTString;

@interface EDTFeedBackViewController ()

@property (nonatomic ,strong) UITextView *signaturetv;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) EDTFeedBackBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UITextView *placeholder;

@property (nonatomic ,strong) UIView *whiteView;

@property (nonatomic ,strong) EDTNickNameTextField *textField;

@property (nonatomic ,copy) EDTFeedBackBlock block;
#if EDTNameOne


#elif EDTNameTwo

@property (nonatomic ,strong) UIImageView *backgroundImageView;

//    self.view.backgroundColor = EDTColorCreate(@EDTProjectColor);

#elif EDTNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif

@end

@implementation EDTFeedBackViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if EDTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createFeedBackWithBlock:(EDTFeedBackBlock)block {
    
    return [[self alloc] initWithFeedBackBlock:block];
}
- (instancetype)initWithFeedBackBlock:(EDTFeedBackBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (EDTNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[EDTNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField EDT_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField EDT_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 203;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入手机号";
        
        [_textField EDT_editType:EDTTextFiledEditTypePhone];
        
        [_textField EDT_maxLength:11];
#if EDTUPDATEVERSION
        _textField.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _textField;
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
#if EDTUPDATEVERSION
        _signaturetv.tintColor = EDTColorCreate(@EDTProjectColor);
#endif
    }
    return _signaturetv;
}
- (UITextView *)placeholder {
    
    if (!_placeholder) {
        
        _placeholder = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _placeholder.font = EDTSYSTEMFONT(15);
        
        _placeholder.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _placeholder.tag = 202;
        
        _placeholder.userInteractionEnabled = false;
        
        _placeholder.text = @"请输入个性昵称";
        
        _placeholder.textColor = EDTColorCreate(@"#999999");
    }
    return _placeholder;
}
- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateDisabled];
        
        _completeItem.titleLabel.font = EDTSYSTEMFONT(15);
        
        _completeItem.tag = 204;
    }
    return _completeItem;
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
    
    [self.view addSubview:self.textField];
#if EDTNameOne
    
    [self.view addSubview:self.completeItem];
    
#elif EDTNameTwo
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self.view addSubview:self.completeItem];
    
#elif EDTNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
#if EDTNameOne
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.equalTo(self.signaturetv.mas_bottom).offset(10);
        
        make.height.mas_equalTo(55);
    }];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(48);
        
        make.top.equalTo(self.textField.mas_bottom).offset(10);
    }];

    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")) forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 24;
    
    self.completeItem.layer.masksToBounds = true;
    
#elif EDTNameTwo
    
    self.backgroundImageView.frame = self.view.bounds;
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    self.whiteView.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80"));
    
    self.placeholder.backgroundColor = [UIColor clearColor];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.equalTo(self.signaturetv.mas_bottom).offset(10);
        
        make.height.mas_equalTo(55);
    }];
    
    self.textField.backgroundColor = EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80"));
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(48);
        
        make.top.equalTo(self.textField.mas_bottom).offset(10);
    }];
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
    
    [self.completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateDisabled];
    
    [self.completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:EDTAlphaColorCreate(EDT_COLOR_FORMAT_STRING(@"#ffffff", @"80")) forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 24;
    
    self.completeItem.layer.masksToBounds = true;
    
#elif EDTNameThree
    
    self.topLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD);
        
        make.height.mas_equalTo(8);
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(EDT_TOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.equalTo(self.signaturetv.mas_bottom).offset(8);
        
        make.height.mas_equalTo(55);
    }];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @EDTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@EDTColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@EDTColor]] forState:UIControlStateDisabled];
    
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"意见与建议";
    
}

- (void)configViewModel {
    
    self.bridge = [EDTFeedBackBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createFeedBack:self feedBackAction:^{
        
        [weakSelf jxt_showAlertWithTitle:@"您的反馈非常重要,我们会尽快处理您的反馈" message:@"点击确定退出当前界面,点击继续反馈重新编辑" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker
            .addActionDefaultTitle(@"继续反馈")
            .addActionDefaultTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"确定"]) {
                
                weakSelf.block(weakSelf);
            } else if ([action.title isEqualToString:@"继续反馈"]) {
                
                weakSelf.textField.text = @"";
                
                weakSelf.signaturetv.text = @"";
            }
        }];
    }];
    
}
- (void)configOwnProperties {
    
#if EDTNameOne
    [super configOwnProperties];
    
#elif EDTNameTwo
    
#elif EDTNameThree
    
    [super configOwnProperties];
#endif
}

- (BOOL)canPanResponse { return true;}

@end
