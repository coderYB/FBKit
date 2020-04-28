//
//  FBLoadingViewController.h
//  TSUIKit
//
//  Created by three stone 王 on 2018/7/10.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

@import FBTransition;
typedef NS_ENUM(NSInteger,FBLoadingStatus) {
    
    FBLoadingStatusBegin,
    
    FBLoadingStatusLoading,
    
    FBLoadingStatusSucc,
    
    FBLoadingStatusFail,
    
    FBLoadingStatusReload
};

@protocol FBLoadingViewDelegate <NSObject>

- (void)onReloadItemClick;

@end

@interface FBLoadingView : UIView

+ (instancetype)loadingWithContentViewController:(FBTViewController *)contentViewController;

/*
 设置加载状态
 FBLoadingStatusBegin 请在viewwillappear里
 FBLoadingStatusLoading 请在设置begin之后 viewwillappear里
 FBLoadingStatusSucc 加载成功
 FBLoadingStatusFail 加载失败
 FBLoadingStatusReload 重新加载 屏幕上有 点击屏幕重新加载按钮
 */
@property (nonatomic ,assign ,readonly) BOOL isLoading;

@property (nonatomic ,assign)FBLoadingStatus status;

- (void)changeLoadingStatus:(FBLoadingStatus )status;

@property (nonatomic ,weak) id<FBLoadingViewDelegate> mDelegate;


@end


@interface FBLoadingViewController : FBTViewController

@property (nonatomic ,strong ,readonly) FBLoadingView *loadingView;

@property (nonatomic ,assign) FBLoadingStatus loadingStatus;

// 重新加载
- (void)onReloadItemClick;

@end
