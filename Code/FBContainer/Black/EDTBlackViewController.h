//
//  EDTBlackViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "EDTConfig.h"
@import EDTBridge;
@import EDTTable;
@import EDTBean;

NS_ASSUME_NONNULL_BEGIN

@interface EDTBlackTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTBlackBean *black;

@end
typedef void(^EDTBlackBlock)(void);
@interface EDTBlackViewController : EDTTableLoadingViewController

+ (instancetype)createBlackWithBlock:(EDTBlackBlock) block;

@end

NS_ASSUME_NONNULL_END
