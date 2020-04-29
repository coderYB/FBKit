//
//  EDTFocusViewController.h
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

@interface EDTFocusTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTFocusBean *focus;

@end
typedef void(^EDTFocusBlock)(void);

@interface EDTFocusViewController : EDTTableLoadingViewController

+ (instancetype)createBlackWithBlock:(EDTFocusBlock) block;

@end

NS_ASSUME_NONNULL_END
