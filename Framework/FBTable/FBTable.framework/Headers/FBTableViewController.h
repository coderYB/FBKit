//
//  FBTableViewController.h
//  FBTable
//
//  Created by 王磊 on 2020/4/23.
//  Copyright © 2020 王磊. All rights reserved.
//

@import FBLoading;
@import MJRefresh;
#import "FBTableViewComponent.h"
NS_ASSUME_NONNULL_BEGIN

@interface FBTableLoadingViewController : FBLoadingViewController

@property (nonatomic ,strong) UITableView *tableView;

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (UIView *)configTableViewSectionHeader:(id)data forSection:(NSInteger)section ;

- (CGFloat )caculateForCell:(id )data forIndexPath:(NSIndexPath *)ip ;

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip;

- (void)tableViewEmptyShow;

- (void)tableViewEmptyHidden;
@end

@interface FBTableNoLoadingViewController : FBTViewController

@property (nonatomic ,strong) UITableView *tableView;

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (UIView *)configTableViewSectionHeader:(id)data forSection:(NSInteger)section ;

- (CGFloat )caculateForCell:(id )data forIndexPath:(NSIndexPath *)ip;

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip;

@property (nonatomic ,strong) FBTableHeaderView *headerView;

@end
NS_ASSUME_NONNULL_END
