//
//  FBAreaViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import FBTable;
@import FBBridge;
#import "FBConfig.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^FBAreaBlock)(FBBaseViewController *from ,FBAreaBean *selectedArea ,FBAreaType type ,BOOL hasNext);

@interface FBAreaViewController : FBTableNoLoadingViewController

+ (instancetype)createAreaWithType:(FBAreaType )type andAreaBlock:(FBAreaBlock) block;

- (void)selectedArea:(NSInteger )sid andBlock:(FBAreaBlock)block;

- (void)updateAreas:(NSInteger )sid ;

- (FBAreaBean *)fetchAreaWithId:(NSInteger)sid ;
@end

NS_ASSUME_NONNULL_END
