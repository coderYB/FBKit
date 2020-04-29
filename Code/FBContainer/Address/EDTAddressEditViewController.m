//
//  EDTAddressEditViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "EDTAddressEditViewController.h"

@import EDTBridge;
@import Masonry;
@import JXTAlertManager;
@import EDTTextField;
@import EDTCommon;
@import EDTColor;

@protocol EDTAddressEditTableViewCellDelegate <NSObject>

- (void)onSwitchTap:(BOOL)value;

- (void)onTextChanged:(NSString *)changed andType:(EDTAddressEditType )type;

@end

@interface EDTAddressEditTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) EDTBaseTextField *subTitleLabel;

@property (nonatomic ,strong) EDTAddressEditBean *addressEdit;

@property (nonatomic ,strong) UISwitch *swi;

@property (nonatomic ,weak) id<EDTAddressEditTableViewCellDelegate> mDelegate;

@end

@implementation EDTAddressEditTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.font = EDTSYSTEMFONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = EDTColorCreate(@"#666666");
    }
    return _titleLabel;
}

- (EDTBaseTextField *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[EDTBaseTextField alloc] initWithFrame:CGRectZero];
        
        _subTitleLabel.font = EDTSYSTEMFONT(15);
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = EDTColorCreate(@"#333333");
    }
    return _subTitleLabel;
}
- (UISwitch *)swi {
    
    if (!_swi) {
        
        _swi = [UISwitch new];
        
        _swi.on = true;
    }
    return _swi;
}
- (void)setAddressEdit:(EDTAddressEditBean *)addressEdit {
    _addressEdit = addressEdit;
    self.titleLabel.text = addressEdit.title;
    
    self.bottomLineType = EDTBottomLineTypeNormal;
    
    self.subTitleLabel.placeholder = addressEdit.placeholder;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.subTitleLabel.userInteractionEnabled = true;
    
    self.subTitleLabel.text = addressEdit.value;
    
    self.swi.hidden = true;
    
    [self.subTitleLabel EDT_editType:EDTTextFiledEditTypeDefault];
    
    [self.subTitleLabel EDT_maxLength:999];
    
    switch (addressEdit.type) {
        case EDTAddressEditTypeName:
            
            
            break;
        case EDTAddressEditTypeDef:
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            self.swi.hidden = false;
            
            break;
        case EDTAddressEditTypeArea:
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            NSLog(@"name =%@======" ,addressEdit.rArea.name);
            
            if (addressEdit.rArea.name && ![addressEdit.rArea.name isEqualToString:@""]) {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@%@",addressEdit.pArea.name,addressEdit.cArea.name,addressEdit.rArea.name];
                
            } else {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@",addressEdit.pArea.name,addressEdit.cArea.name];
                
            }
            break;
        case EDTAddressEditTypePhone:
            
            [self.subTitleLabel EDT_editType:EDTTextFiledEditTypePhone];
            
            [self.subTitleLabel EDT_maxLength:11];
            break;
        default:
            break;
    }
    
}


- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.swi];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.swi addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    
    [self.subTitleLabel EDT_textChanged:^(EDTBaseTextField * _Nonnull tf) {
        
        [weakSelf.mDelegate onTextChanged:tf.text andType:weakSelf.addressEdit.type];
    }];
    
}

- (void)onSwitchValueChanged:(UISwitch *)swi {
    
    [self.mDelegate onSwitchTap:swi.isOn];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.width.mas_equalTo(CGRectGetWidth(self.bounds) / 2);
        
        make.centerY.equalTo(self);
    }];
    
    [self.swi mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
        
        make.width.mas_equalTo(50);
        
        make.height.mas_equalTo(25);
    }];
}

@end

@interface EDTAddressEditViewController() <EDTAddressEditTableViewCellDelegate>

@property (nonatomic ,strong) EDTAddressEditBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) EDTAddressBean *addressBean;

@property (nonatomic ,copy) EDTAddressEditBlock block;

@end

@implementation EDTAddressEditViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = EDTSYSTEMFONT(15);
        
//        if ([@EDTColor isEqualToString:@"#ffffff"]) {
//            
//            [_completeItem setTitleColor:EDTColorCreate(@"#666666") forState:UIControlStateNormal];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
//            
//        } else {
//            
//            [_completeItem setTitleColor:EDTColorCreate(@"#ffffff") forState:UIControlStateNormal];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
//        }
    }
    return _completeItem;
}
+ (instancetype)creatAddressEditWithAddressBean:(EDTAddressBean *)addressBean andAddressEditBlock:(EDTAddressEditBlock)block {
    
    return [[self alloc] initWithAddressBean:addressBean andAddressEditBlock:block];
}
- (instancetype)initWithAddressBean:(EDTAddressBean *)addressBean andAddressEditBlock:(EDTAddressEditBlock)block {
    
    if (self = [super init]) {
        
        self.addressBean = addressBean;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[EDTAddressEditTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTAddressEditTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[EDTAddressEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.addressEdit = data;
    
    cell.mDelegate = self;
    
    return cell;
    
}
- (void)onSwitchTap:(BOOL)value {
    
    [self.bridge updateAddressEditDefWithIsDef:value];
}
- (void)onTextChanged:(NSString *)changed andType:(EDTAddressEditType)type {
    
    [self.bridge updateAddressEditWithType:type value:changed];
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTAddressEditBean *edit = (EDTAddressEditBean *)data;
    
    switch (edit.type) {
        case EDTAddressEditTypeArea:
        {
            self.block(self, EDTAddressEditActionTypeArea,self.addressBean, edit);
        }
            break;
            
        default:
            break;
    }
}
- (void)updateAddressEditArea:(EDTAddressEditBean *)addressEditBean {
    
    [self updatePArea:addressEditBean.pArea andCArea:addressEditBean.cArea andRArea:addressEditBean.rArea];
}
- (void)updatePArea:(EDTAreaBean *)pArea andCArea:(EDTAreaBean *)cArea andRArea:(EDTAreaBean *)rArea {
    
    [self.bridge updateAddressEditAreaWithPid:pArea.areaId pName:pArea.name cid:cArea.areaId cName:cArea.name rid:rArea.areaId rName:rArea.name];
}
- (void)configNaviItem {
    
    self.title = self.addressBean ? @"编辑地址" : @"新增地址";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}
- (void)configViewModel {
    
    self.bridge = [EDTAddressEditBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createAddressEdit:self temp:self.addressBean editAction:^(EDTAddressBean * _Nullable addressBean) {
        
        weakSelf.block(weakSelf,EDTAddressEditActionTypeCompleted, addressBean, nil);
    }];
    
    if (self.addressBean) {
        
        [self.bridge updateAddressEditDefWithIsDef:self.addressBean.isdel];
        
        [self.bridge updateAddressEditWithType:EDTAddressEditTypeName value:self.addressBean.name];
        
        [self.bridge updateAddressEditWithType:EDTAddressEditTypePhone value:self.addressBean.phone];
        
        [self.bridge updateAddressEditWithType:EDTAddressEditTypeDetail value:self.addressBean.addr];
        
        [self.bridge updateAddressEditAreaWithPid:self.addressBean.plcl pName:self.addressBean.plclne cid:self.addressBean.city cName:self.addressBean.cityne rid:self.addressBean.region rName:self.addressBean.regionne];
        
        [self.tableView reloadData];
    }
    
}
@end
