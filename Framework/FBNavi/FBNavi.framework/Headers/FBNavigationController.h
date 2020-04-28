//
//  FBNavigationController.h
//  ZNavi
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBBarButtonItemExtensions.h"
#import "FBNavigationBarExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FBNavigationConfig <NSObject>

@property (nonatomic ,assign) CGFloat FBFontSize;

@property (nonatomic ,strong) UIColor *FBNormalTitleColor;

@property (nonatomic ,strong) UIColor *FBLoginTitleColor;

@property (nonatomic ,strong) UIColor *FBNormalBackgroundColor;

@property (nonatomic ,strong) UIColor *FBLoginBackgroundColor;

@property (nonatomic ,copy) NSString *FBNormalBackImage;

@property (nonatomic ,copy) NSString *FBLoginBackImage;

@end

@interface FBNavigationController : UINavigationController

+ (void)initWithConfig:(id <FBNavigationConfig>) config;

@end

NS_ASSUME_NONNULL_END
