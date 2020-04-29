//
//  FBAboutViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//


#import "FBConfig.h"
@import FBBridge;
@import FBTable;
NS_ASSUME_NONNULL_BEGIN

@interface FBAboutTableHeaderView : FBTableHeaderView

@end

@interface FBAboutTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBAboutBean *about;

@end

@interface FBAboutViewController : FBTableNoLoadingViewController

+ (instancetype)createAbout;

@end

NS_ASSUME_NONNULL_END
