//
//  FBAreaHeaderViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//


#import "FBConfig.h"
@import FBCollection;
@import FBBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^FBAreaHeaderBlock)(FBBaseViewController *from ,FBAreaBean *pArea ,FBAreaBean *cArea ,FBAreaBean *_Nullable rArea);

@interface FBAreaHeaderViewController : FBCollectionNoLoadingViewController

+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger )rid andAreaHeaderBlock:(FBAreaHeaderBlock) block;

@end

@interface FBAreaPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

@interface FBAreaDismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

NS_ASSUME_NONNULL_END
