//
//  EDTUserInfoViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "EDTConfig.h"
@import EDTBridge;
@import EDTTable;

NS_ASSUME_NONNULL_BEGIN

@interface EDTUserInfoTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTUserInfoBean *userInfo;

@end

typedef NS_ENUM(NSInteger, EDTUserInfoActionType) {
    EDTUserInfoActionTypeName,
    EDTUserInfoActionTypeSignature,
};

typedef void(^EDTUserInfoBlock)(EDTUserInfoActionType actionType ,EDTBaseViewController *from);

@interface EDTUserInfoViewController : EDTTableNoLoadingViewController

+ (instancetype)createUserInfoWithBlock:(EDTUserInfoBlock )block;

- (void)updateName:(NSString *)name;

- (void)updateSignature:(NSString *)signature;

@end

NS_ASSUME_NONNULL_END
