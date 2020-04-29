//
//  EDTAddressViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "EDTAddressViewController.h"
@import Masonry;
@import EDTCommon;
@import EDTColor;
@import EDTImage;
@import EDTString;
@import JXTAlertManager;

@interface EDTAddressTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTAddressBean *address;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@property (nonatomic ,strong) UILabel *phoneLabel;
@end
@implementation EDTAddressTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.font = EDTSYSTEMFONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = EDTColorCreate(@"#333333");
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = EDT_LABEL_NEW;
        
        _subTitleLabel.font = EDTSYSTEMFONT(12);
        
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        _subTitleLabel.textColor = EDTColorCreate(@"#666666");
    }
    return _subTitleLabel;
}

- (UILabel *)phoneLabel {
    
    if (!_phoneLabel) {
        
        _phoneLabel = EDT_LABEL_NEW;
        
        _phoneLabel.font = EDTSYSTEMFONT(15);
        
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        
        _phoneLabel.textColor = EDTColorCreate(@"#333333");
    }
    return _phoneLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.phoneLabel];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.bottomLineType = EDTBottomLineTypeNormal;
}

- (void)setAddress:(EDTAddressBean *)address {
    
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
@interface EDTAddressViewController ()

@property (nonatomic ,strong) EDTAddressBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy ) EDTAddressBlock addressBlock;
@end

@implementation EDTAddressViewController

+ (instancetype)createAddressWithBlock:(EDTAddressBlock) addressBlock {
    
    return [[EDTAddressViewController alloc] initWithBlock:addressBlock];
}
- (instancetype)initWithBlock:(EDTAddressBlock) addressBlock {
    
    if (self = [super init]) {
        
        self.addressBlock = addressBlock;
    }
    return self;
}

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 301;
        
        [_completeItem setBackgroundImage:[UIImage EDTTransformFromHexValue:@EDTProjectColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage EDTTransformFromAlphaHexValue:EDT_COLOR_FORMAT_STRING(@EDTProjectColor, @"80")] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"+ 新增地址" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"+ 新增地址" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.cornerRadius = 24;
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = EDTSYSTEMFONT(15);
    }
    return _completeItem;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:false];
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.completeItem];

}
- (void)configOwnSubViews {
    
    [self.tableView registerClass:[EDTAddressTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_footer.hidden = true;
    
    self.tableView.mj_insetT = 1;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTAddressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[EDTAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.address = data;
    
    return cell;
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip  {
    
    self.addressBlock(EDTAddressActionTypeEdit, data, ip,self);
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
    
    self.bridge = [EDTAddressBridge new];
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
    } addressAction:^(enum EDTAddressActionType actionType, NSIndexPath * _Nullable ip, EDTAddressBean * _Nullable addressBean) {
        
        switch (actionType) {
            case EDTAddressActionTypeDelete:
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

- (void)alertShow:(EDTAddressBean *)address andIp:(NSIndexPath *)ip {
    
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
- (void)updateAddress:(EDTAddressBean *)addressBean andIp:(NSIndexPath *)ip {
    
    [self.bridge updateAddress:addressBean ip:ip];
}
- (void)insertAddress:(EDTAddressBean *)addressBean {
    
    [self.bridge insertAddress:addressBean addressAction:^(enum EDTAddressActionType actionType, NSIndexPath * _Nullable ip, EDTAddressBean * _Nullable address) {
       
        
    }];
}

- (void)onReloadItemClick {
    [super onReloadItemClick];
    
    [self.tableView.mj_header beginRefreshing];
}

- (BOOL)canPanResponse { return true; }

- (void)configNaviItem {
    
    self.title = @"我的地址";
}

- (BOOL)prefersStatusBarHidden {
    
    return false;
}

@end
