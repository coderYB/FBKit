//
//  FBWelcomeViewController.h
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

@import FBCollection;
#import "FBConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface FBWelcomeCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy) NSString *icon;

@end

typedef void(^FBWelcomeBlock)(FBBaseViewController *from);

@interface FBWelcomeViewController : FBCollectionNoLoadingViewController

+ (instancetype)createWelcomeWithSkipBlock:(FBWelcomeBlock )block;

@end

NS_ASSUME_NONNULL_END
