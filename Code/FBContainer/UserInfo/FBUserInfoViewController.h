//
//  FBUserInfoViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "FBConfig.h"
@import FBBridge;
@import FBTable;

NS_ASSUME_NONNULL_BEGIN

@interface FBUserInfoTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBUserInfoBean *userInfo;

@end

typedef NS_ENUM(NSInteger, FBUserInfoActionType) {
    FBUserInfoActionTypeName,
    FBUserInfoActionTypeSignature,
};

typedef void(^FBUserInfoBlock)(FBUserInfoActionType actionType ,FBBaseViewController *from);

@interface FBUserInfoViewController : FBTableNoLoadingViewController

+ (instancetype)createUserInfoWithBlock:(FBUserInfoBlock )block;

- (void)updateName:(NSString *)name;

- (void)updateSignature:(NSString *)signature;

@end

NS_ASSUME_NONNULL_END
