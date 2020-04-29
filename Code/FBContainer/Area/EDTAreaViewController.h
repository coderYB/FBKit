//
//  EDTAreaViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import EDTTable;
@import EDTBridge;
#import "EDTConfig.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^EDTAreaBlock)(EDTBaseViewController *from ,EDTAreaBean *selectedArea ,EDTAreaType type ,BOOL hasNext);

@interface EDTAreaViewController : EDTTableNoLoadingViewController

+ (instancetype)createAreaWithType:(EDTAreaType )type andAreaBlock:(EDTAreaBlock) block;

- (void)selectedArea:(NSInteger )sid andBlock:(EDTAreaBlock)block;

- (void)updateAreas:(NSInteger )sid ;

- (EDTAreaBean *)fetchAreaWithId:(NSInteger)sid ;
@end

NS_ASSUME_NONNULL_END
