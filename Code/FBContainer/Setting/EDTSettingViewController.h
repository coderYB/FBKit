//
//  EDTSettingViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTConfig.h"
@import EDTBridge;
@import EDTTable;

NS_ASSUME_NONNULL_BEGIN

@interface EDTSettingTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTSettingBean *setting;

@end

typedef void(^EDTSettingBlock)(EDTSettingActionType actionType ,EDTBaseViewController *from);

@interface EDTSettingViewController : EDTTableNoLoadingViewController

+ (instancetype)createSettingWithBlock:(EDTSettingBlock) block;

- (void)updateTableData;
@end

NS_ASSUME_NONNULL_END
