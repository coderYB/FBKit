//
//  EDTAboutViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//


#import "EDTConfig.h"
@import EDTBridge;
@import EDTTable;
NS_ASSUME_NONNULL_BEGIN

@interface EDTAboutTableHeaderView : EDTTableHeaderView

@end

@interface EDTAboutTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTAboutBean *about;

@end

@interface EDTAboutViewController : EDTTableNoLoadingViewController

+ (instancetype)createAbout;

@end

NS_ASSUME_NONNULL_END
