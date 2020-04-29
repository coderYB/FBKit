//
//  EDTPrivacyViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTPrivacyViewController.h"

@interface EDTPrivacyViewController ()

@property (nonatomic ,strong) EDTProtocolBridge *bridge;

#if EDTUserInfoOne

#elif EDTUserInfoTwo

#elif EDTUserInfoThree

@property (nonatomic ,strong) UIView *topLine;
#else


#endif
@end

@implementation EDTPrivacyViewController

#if EDTUserInfoOne

#elif EDTUserInfoTwo

#elif EDTUserInfoThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
#else


#endif
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if EDTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}


+ (instancetype)createPrivacy {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [EDTProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
#if EDTUserInfoOne
    
    
#elif EDTUserInfoTwo
    
#elif EDTUserInfoThree
    
    [self.view addSubview:self.topLine];
#else
    
    
#endif
    
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if EDTUserInfoOne
    
#elif EDTUserInfoTwo
    
    
#elif EDTUserInfoThree
    
    self.topLine.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:NSClassFromString(@"EDTLoginViewController")]) {
        
        CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        
        self.topLine.frame = CGRectMake(15, h, EDT_VIEWCONTROLLER_WIDTH - 30, 8);
        
    } else {
        
        CGFloat h = EDT_TOPLAYOUTGUARD;
        
        self.topLine.frame = CGRectMake(15, h, EDT_VIEWCONTROLLER_WIDTH - 30, 8);
    }
    
    CGRect initFrame = self.textView.frame;
    
    CGRect finalFrame = CGRectOffset(initFrame, 0, 8);
    
    self.textView.frame = finalFrame;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if EDTUserInfoOne
    
#elif EDTUserInfoTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
    self.textView.layer.masksToBounds = false;
    
#elif EDTUserInfoThree
    
    
#else
    
    
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"隐私与协议";
}
- (BOOL)canPanResponse {
    return true;
}

@end
