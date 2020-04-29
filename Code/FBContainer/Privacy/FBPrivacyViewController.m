//
//  FBPrivacyViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBPrivacyViewController.h"

@interface FBPrivacyViewController ()

@property (nonatomic ,strong) FBProtocolBridge *bridge;

#if FBUserInfoOne

#elif FBUserInfoTwo

#elif FBUserInfoThree

@property (nonatomic ,strong) UIView *topLine;
#else


#endif
@end

@implementation FBPrivacyViewController

#if FBUserInfoOne

#elif FBUserInfoTwo

#elif FBUserInfoThree

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
    
#if FBPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}


+ (instancetype)createPrivacy {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [FBProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
#if FBUserInfoOne
    
    
#elif FBUserInfoTwo
    
#elif FBUserInfoThree
    
    [self.view addSubview:self.topLine];
#else
    
    
#endif
    
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if FBUserInfoOne
    
#elif FBUserInfoTwo
    
    
#elif FBUserInfoThree
    
    self.topLine.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
    
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:NSClassFromString(@"FBLoginViewController")]) {
        
        CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        
        self.topLine.frame = CGRectMake(15, h, FB_VIEWCONTROLLER_WIDTH - 30, 8);
        
    } else {
        
        CGFloat h = FB_TOPLAYOUTGUARD;
        
        self.topLine.frame = CGRectMake(15, h, FB_VIEWCONTROLLER_WIDTH - 30, 8);
    }
    
    CGRect initFrame = self.textView.frame;
    
    CGRect finalFrame = CGRectOffset(initFrame, 0, 8);
    
    self.textView.frame = finalFrame;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if FBUserInfoOne
    
#elif FBUserInfoTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
    
    self.textView.layer.masksToBounds = false;
    
#elif FBUserInfoThree
    
    
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
