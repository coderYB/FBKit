//
//  FBAddressSelectedViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "FBAddressSelectedViewController.h"

@import Masonry;
@import FBCommon;
@import FBColor;
@import JXTAlertManager;
@import FBImage;
@import FBString;

@interface FBAddressSelectFBableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBAddressBean *address;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@property (nonatomic ,strong) UILabel *phoneLabel;
@end
@implementation FBAddressSelectFBableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.font = FB_SYSTEM_FONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = FB_COLOR_CREATE(@"#333333");
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = FB_LABEL_NEW;
        
        _subTitleLabel.font = FB_SYSTEM_FONT(12);
        
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        _subTitleLabel.textColor = FB_COLOR_CREATE(@"#666666");
    }
    return _subTitleLabel;
}

- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = FB_LABEL_NEW;
        
        _phoneLabel.font = FB_SYSTEM_FONT(15);
        
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        
        _phoneLabel.textColor = FB_COLOR_CREATE(@"#333333");
    }
    return _phoneLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.phoneLabel];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.bottomLineType = FBBottomLineTypeNormal;
    
}

- (void)setAddress:(FBAddressBean *)address {
    
    self.titleLabel.text = address.name;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.phoneLabel.text = address.phone;
    
    if (address.regionne && [address.regionne isEqualToString:@""]) {
        
        self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@%@",address.plclne,address.cityne,address.addr];
    } else {
        
        self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@%@%@",address.plclne,address.cityne,address.regionne,address.addr];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.top.mas_equalTo(15);
        
        make.width.mas_equalTo(80);
        
        make.height.mas_equalTo(25);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(15);
        
        make.width.mas_equalTo(100);
        
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        
        make.height.mas_equalTo(25);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        
        make.height.mas_equalTo(20);
    }];
}
@end

@interface FBAddressSelectedViewController ()

@property (nonatomic ,strong) FBAddressBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) FBAddressSelectedBlock addressBlock;

@end

@implementation FBAddressSelectedViewController

+ (instancetype)createAddressSelectedWithBlock:(FBAddressSelectedBlock) addressBlock {
    
    return [[FBAddressSelectedViewController alloc] initWithBlock:addressBlock];
}
- (instancetype)initWithBlock:(FBAddressSelectedBlock) addressBlock {
    
    if (self = [super init]) {
        
        self.addressBlock = addressBlock;
    }
    return self;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = FB_BUTTON_NEW;
        
        _completeItem.tag = 301;
        
        [_completeItem setBackgroundImage:[UIImage FBTransformFromHexValue:@FBProjectColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage FBTransformFromAlphaHexValue:FB_COLOR_FORMAT_STRING(@FBProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"+ 新增地址" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"+ 新增地址" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.cornerRadius = 24;
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = FB_SYSTEM_FONT(15);
    }
    return _completeItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if FBPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.completeItem];
    
}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[FBAddressSelectFBableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_footer.hidden = true;
    
    self.tableView.mj_insetT = 1;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBAddressSelectFBableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[FBAddressSelectFBableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.address = data;
    
    return cell;
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip  {
    
    self.addressBlock(FBAddressActionTypeEdit, data, ip,self);
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CGFloat height = 0;
    
    height += 15;
    
    height += 25;
    
    height += 5;
    
    height += 20;
    
    height += 15;
    
    return height;
}

- (void)configViewModel {
    
    self.bridge = [FBAddressBridge new];
    // -1 失败  0 成功  1空
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createAddress:self status:^(NSInteger status) {
        
        if (status == -1) {
            
            
        } else if (status == 0) {
            
            [weakSelf.view addSubview:weakSelf.completeItem];
            
            [weakSelf.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(20);
                
                make.right.bottom.mas_equalTo(-20);
                
                make.height.mas_equalTo(48);
            }];
        } else if (status == 1) {
            
            UIView *emptyView = nil;
            
            for (UIView *aView in weakSelf.view.subviews) {
                
                if ([aView isKindOfClass:NSClassFromString(@"ZEmptyView")]) {
                    
                    emptyView = (UIView *)NSClassFromString(@"ZEmptyView");
                    
                    break;
                }
            }
            
            if (emptyView) {
                
                [weakSelf.view insertSubview:weakSelf.completeItem aboveSubview:emptyView];
            } else {
                
                [weakSelf.view addSubview:weakSelf.completeItem];
            }
            
            [weakSelf.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(20);
                
                make.right.bottom.mas_equalTo(-20);
                
                make.height.mas_equalTo(48);
            }];
        }
    } addressAction:^(enum FBAddressActionType actionType, NSIndexPath * _Nullable ip, FBAddressBean * _Nullable addressBean) {
        
        switch (actionType) {
            case FBAddressActionTypeDelete:
            {
                
                [weakSelf alertShow:addressBean andIp:ip];
            }
                break;
                
            default:
                weakSelf.addressBlock(actionType, addressBean, ip ,weakSelf);
                break;
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)alertShow:(FBAddressBean *)address andIp:(NSIndexPath *)ip {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showAlertWithTitle:@"点击确定删除地址" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker
        .addActionCancelTitle(@"取消")
        .addActionDefaultTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"确定"]) {
            
            [weakSelf.bridge removeAddress:address ip:ip];
        }
    }];
}
- (void)updateAddress:(FBAddressBean *)addressBean andIp:(NSIndexPath *)ip {
    
    [self.bridge updateAddress:addressBean ip:ip];
}

- (void)insertAddress:(FBAddressBean *)addressBean {
    
    [self.bridge insertAddress:addressBean addressAction:^(enum FBAddressActionType actionType, NSIndexPath * _Nullable ip, FBAddressBean * _Nullable address) {
        
        
    }];
}
- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}

- (BOOL)canPanResponse { return true; }

- (void)configNaviItem {
    
    self.title = @"选择地址";
}

- (BOOL)prefersStatusBarHidden {
    
    return false;
}

@end
