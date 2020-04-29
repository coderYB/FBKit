//
//  FBProtocolViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBProtocolViewController.h"
@import FBBridge;
@interface FBProtocolViewController ()

@property (nonatomic ,strong) FBProtocolBridge *bridge;

#if FBLoginOne

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif FBLoginTwo

#elif FBLoginThree

@property (nonatomic ,strong) UIView *topLine;

#elif FBLoginFour

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else


#endif
@end

@implementation FBProtocolViewController

#if FBLoginOne

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

#elif FBLoginTwo

#elif FBLoginThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#elif FBLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
#else


#endif
+ (instancetype)createProtocol {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [FBProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if FBLoginOne
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
#elif FBLoginTwo
    
#elif FBLoginThree
    
    [self.view addSubview:self.topLine];
#elif FBLoginFour
    
    
    
#else
    
    
#endif
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if FBLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.textView.backgroundColor = [UIColor clearColor];
    
#elif FBLoginTwo
    
    self.textView.textColor = [UIColor whiteColor];
    
    self.textView.editable = false;
    
#elif FBLoginThree
    
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
#elif FBLoginFour
    
    self.backgroundImageView.frame = self.view.bounds;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if FBLoginOne
    
#elif FBLoginTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
    
    self.textView.layer.masksToBounds = false;
    
#elif FBLoginThree
    
    
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
