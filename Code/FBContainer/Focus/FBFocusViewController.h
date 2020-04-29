//
//  FBFocusViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBConfig.h"
@import FBBridge;
@import FBTable;
@import FBBean;

NS_ASSUME_NONNULL_BEGIN

@interface FBFocusTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBFocusBean *focus;

@end
typedef void(^FBFocusBlock)(void);

@interface FBFocusViewController : FBTableLoadingViewController

+ (instancetype)createBlackWithBlock:(FBFocusBlock) block;

@end

NS_ASSUME_NONNULL_END
