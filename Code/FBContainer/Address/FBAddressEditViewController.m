//
//  FBAddressEditViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "FBAddressEditViewController.h"

@import FBBridge;
@import Masonry;
@import JXTAlertManager;
@import FBTextField;
@import FBCommon;
@import FBColor;

@protocol FBAddressEditTableViewCellDelegate <NSObject>

- (void)onSwitchTap:(BOOL)value;

- (void)onTextChanged:(NSString *)changed andType:(FBAddressEditType )type;

@end

@interface FBAddressEditTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) FBBaseTextField *subTitleLabel;

@property (nonatomic ,strong) FBAddressEditBean *addressEdit;

@property (nonatomic ,strong) UISwitch *swi;

@property (nonatomic ,weak) id<FBAddressEditTableViewCellDelegate> mDelegate;

@end

@implementation FBAddressEditTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.font = FB_SYSTEM_FONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = FB_COLOR_CREATE(@"#666666");
    }
    return _titleLabel;
}

- (FBBaseTextField *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[FBBaseTextField alloc] initWithFrame:CGRectZero];
        
        _subTitleLabel.font = FB_SYSTEM_FONT(15);
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = FB_COLOR_CREATE(@"#333333");
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
- (void)setAddressEdit:(FBAddressEditBean *)addressEdit {
    _addressEdit = addressEdit;
    self.titleLabel.text = addressEdit.title;
    
    self.bottomLineType = FBBottomLineTypeNormal;
    
    self.subTitleLabel.placeholder = addressEdit.placeholder;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.subTitleLabel.userInteractionEnabled = true;
    
    self.subTitleLabel.text = addressEdit.value;
    
    self.swi.hidden = true;
    
    [self.subTitleLabel FB_editType:FBTextFiledEditTypeDefault];
    
    [self.subTitleLabel FB_maxLength:999];
    
    switch (addressEdit.type) {
        case FBAddressEditTypeName:
            
            
            break;
        case FBAddressEditTypeDef:
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            self.swi.hidden = false;
            
            break;
        case FBAddressEditTypeArea:
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            NSLog(@"name =%@======" ,addressEdit.rArea.name);
            
            if (addressEdit.rArea.name && ![addressEdit.rArea.name isEqualToString:@""]) {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@%@",addressEdit.pArea.name,addressEdit.cArea.name,addressEdit.rArea.name];
                
            } else {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@",addressEdit.pArea.name,addressEdit.cArea.name];
                
            }
            break;
        case FBAddressEditTypePhone:
            
            [self.subTitleLabel FB_editType:FBTextFiledEditTypePhone];
            
            [self.subTitleLabel FB_maxLength:11];
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
    
    [self.subTitleLabel FB_textChanged:^(FBBaseTextField * _Nonnull tf) {
        
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

@interface FBAddressEditViewController() <FBAddressEditTableViewCellDelegate>

@property (nonatomic ,strong) FBAddressEditBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) FBAddressBean *addressBean;

@property (nonatomic ,copy) FBAddressEditBlock block;

@end

@implementation FBAddressEditViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = FB_BUTTON_NEW;
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = FB_SYSTEM_FONT(15);
        
//        if ([@FBColor isEqualToString:@"#ffffff"]) {
//            
//            [_completeItem setTitleColor:FB_COLOR_CREATE(@"#666666") forState:UIControlStateNormal];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
//            
//        } else {
//            
//            [_completeItem setTitleColor:FB_COLOR_CREATE(@"#ffffff") forState:UIControlStateNormal];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
//            
//            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
//        }
    }
    return _completeItem;
}
+ (instancetype)creatAddressEditWithAddressBean:(FBAddressBean *)addressBean andAddressEditBlock:(FBAddressEditBlock)block {
    
    return [[self alloc] initWithAddressBean:addressBean andAddressEditBlock:block];
}
- (instancetype)initWithAddressBean:(FBAddressBean *)addressBean andAddressEditBlock:(FBAddressEditBlock)block {
    
    if (self = [super init]) {
        
        self.addressBean = addressBean;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[FBAddressEditTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBAddressEditTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[FBAddressEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.addressEdit = data;
    
    cell.mDelegate = self;
    
    return cell;
    
}
- (void)onSwitchTap:(BOOL)value {
    
    [self.bridge updateAddressEditDefWithIsDef:value];
}
- (void)onTextChanged:(NSString *)changed andType:(FBAddressEditType)type {
    
    [self.bridge updateAddressEditWithType:type value:changed];
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBAddressEditBean *edit = (FBAddressEditBean *)data;
    
    switch (edit.type) {
        case FBAddressEditTypeArea:
        {
            self.block(self, FBAddressEditActionTypeArea,self.addressBean, edit);
        }
            break;
            
        default:
            break;
    }
}
- (void)updateAddressEditArea:(FBAddressEditBean *)addressEditBean {
    
    [self updatePArea:addressEditBean.pArea andCArea:addressEditBean.cArea andRArea:addressEditBean.rArea];
}
- (void)updatePArea:(FBAreaBean *)pArea andCArea:(FBAreaBean *)cArea andRArea:(FBAreaBean *)rArea {
    
    [self.bridge updateAddressEditAreaWithPid:pArea.areaId pName:pArea.name cid:cArea.areaId cName:cArea.name rid:rArea.areaId rName:rArea.name];
}
- (void)configNaviItem {
    
    self.title = self.addressBean ? @"编辑地址" : @"新增地址";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}
- (void)configViewModel {
    
    self.bridge = [FBAddressEditBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createAddressEdit:self temp:self.addressBean editAction:^(FBAddressBean * _Nullable addressBean) {
        
        weakSelf.block(weakSelf,FBAddressEditActionTypeCompleted, addressBean, nil);
    }];
    
    if (self.addressBean) {
        
        [self.bridge updateAddressEditDefWithIsDef:self.addressBean.isdel];
        
        [self.bridge updateAddressEditWithType:FBAddressEditTypeName value:self.addressBean.name];
        
        [self.bridge updateAddressEditWithType:FBAddressEditTypePhone value:self.addressBean.phone];
        
        [self.bridge updateAddressEditWithType:FBAddressEditTypeDetail value:self.addressBean.addr];
        
        [self.bridge updateAddressEditAreaWithPid:self.addressBean.plcl pName:self.addressBean.plclne cid:self.addressBean.city cName:self.addressBean.cityne rid:self.addressBean.region rName:self.addressBean.regionne];
        
        [self.tableView reloadData];
    }
    
}
@end
