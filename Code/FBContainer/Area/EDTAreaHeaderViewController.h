//
//  EDTAreaHeaderViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//


#import "EDTConfig.h"
@import EDTCollection;
@import EDTBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^EDTAreaHeaderBlock)(EDTBaseViewController *from ,EDTAreaBean *pArea ,EDTAreaBean *cArea ,EDTAreaBean *_Nullable rArea);

@interface EDTAreaHeaderViewController : EDTCollectionNoLoadingViewController

+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger )rid andAreaHeaderBlock:(EDTAreaHeaderBlock) block;

@end

@interface EDTAreaPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

@interface EDTAreaDismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

NS_ASSUME_NONNULL_END
