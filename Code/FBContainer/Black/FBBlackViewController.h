//
//  FBBlackViewController.h
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

@interface FBBlackTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBBlackBean *black;

@end
typedef void(^FBBlackBlock)(void);
@interface FBBlackViewController : FBTableLoadingViewController

+ (instancetype)createBlackWithBlock:(FBBlackBlock) block;

@end

NS_ASSUME_NONNULL_END
