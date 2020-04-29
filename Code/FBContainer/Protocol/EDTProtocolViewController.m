//
//  EDTProtocolViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTProtocolViewController.h"
@import EDTBridge;
@interface EDTProtocolViewController ()

@property (nonatomic ,strong) EDTProtocolBridge *bridge;

#if EDTLoginOne

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif EDTLoginTwo

#elif EDTLoginThree

@property (nonatomic ,strong) UIView *topLine;

#elif EDTLoginFour

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else


#endif
@end

@implementation EDTProtocolViewController

#if EDTLoginOne

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

#elif EDTLoginTwo

#elif EDTLoginThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#elif EDTLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
        
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
    
    self.bridge = [EDTProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if EDTLoginOne
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
#elif EDTLoginTwo
    
#elif EDTLoginThree
    
    [self.view addSubview:self.topLine];
#elif EDTLoginFour
    
    
    
#else
    
    
#endif
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if EDTLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.textView.backgroundColor = [UIColor clearColor];
    
#elif EDTLoginTwo
    
    self.textView.textColor = [UIColor whiteColor];
    
    self.textView.editable = false;
    
#elif EDTLoginThree
    
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
#elif EDTLoginFour
    
    self.backgroundImageView.frame = self.view.bounds;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if EDTLoginOne
    
#elif EDTLoginTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = EDTColorCreate(@EDTProjectColor);
    
    self.textView.layer.masksToBounds = false;
    
#elif EDTLoginThree
    
    
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
