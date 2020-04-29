//
//  EDTWelcomeViewController.h
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

@import EDTCollection;
#import "EDTConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface EDTWelcomeCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy) NSString *icon;

@end

typedef void(^EDTWelcomeBlock)(EDTBaseViewController *from);

@interface EDTWelcomeViewController : EDTCollectionNoLoadingViewController

+ (instancetype)createWelcomeWithSkipBlock:(EDTWelcomeBlock )block;

@end

NS_ASSUME_NONNULL_END
