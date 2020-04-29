//
//  FBSettingViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBConfig.h"
@import FBBridge;
@import FBTable;

NS_ASSUME_NONNULL_BEGIN

@interface FBSettingTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBSettingBean *setting;

@end

typedef void(^FBSettingBlock)(FBSettingActionType actionType ,FBBaseViewController *from);

@interface FBSettingViewController : FBTableNoLoadingViewController

+ (instancetype)createSettingWithBlock:(FBSettingBlock) block;

- (void)updateTableData;
@end

NS_ASSUME_NONNULL_END
