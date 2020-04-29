//
//  EDTSettingViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTSettingViewController.h"
@import EDTColor;
@import Masonry;
@import SDWebImage;
@import EDTCommon;

@interface EDTSettingTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UISwitch *swiItem;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end

@implementation EDTSettingTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.font = EDTSYSTEMFONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = EDTColorCreate(@"#333333");
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = EDT_LABEL_NEW;
        
        _subTitleLabel.font = EDTSYSTEMFONT(15);
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = EDTColorCreate(@"#999999");
    }
    return _subTitleLabel;
}

- (UISwitch *)swiItem {
    if (!_swiItem) {
        
        _swiItem = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        _swiItem.onTintColor = EDTColorCreate(@EDTProjectColor);
        
        _swiItem.thumbTintColor = [UIColor whiteColor];
    }
    return _swiItem;
}
- (void)setSetting:(EDTSettingBean *)setting {
    //    _setting = setting;
    
    self.swiItem.hidden = true;
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.titleLabel.textColor =  EDTColorCreate(@"#333333");
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.bottomLineType = EDTBottomLineTypeNormal;
    
    self.subTitleLabel.hidden = true;
    
    self.subTitleLabel.text = setting.subTitle;
    
    self.backgroundColor = EDTColorCreate(@"#ffffff");
    
    switch (setting.type) {
        case EDTSettingTypeLogout:
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.titleLabel.textColor =  EDTColorCreate(@EDTProjectColor);
            break;
        case EDTSettingTypeSpace:
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.bottomLineType = EDTBottomLineTypeNone;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
        case EDTSettingTypePush:
            
            self.swiItem.hidden = false;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
        case EDTSettingTypeClear:
            
            self.subTitleLabel.hidden = false;
            
        default:
            break;
    }
    
    self.titleLabel.text = setting.title;
    
#if EDTUserInfoOne
    
#elif EDTUserInfoTwo
    
#elif EDTUserInfoThree
    
    if (setting.type == EDTSettingTypeSpace) {
        
        self.backgroundColor = EDTColorCreate(@EDTProjectColor);
    } else {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
#endif
    
}


- (void)commitInit {
    [super commitInit];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.swiItem];
    
    [self.contentView addSubview:self.subTitleLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.swiItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
@end
@interface EDTSettingViewController ()

@property (nonatomic ,strong) EDTSettingBridge *bridge;

@property (nonatomic ,copy) EDTSettingBlock block;

@end

@implementation EDTSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if EDTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createSettingWithBlock:(EDTSettingBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(EDTSettingBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[EDTSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
    
    background.frame = self.view.bounds;
    
    self.tableView.backgroundView = background;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.setting = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [EDTSettingBridge new];
    
    __weak typeof(self) weakSelf = self;
    
#if EDTUserInfoOne
    
    [self.bridge createSetting:self hasSpace:true settingAction:^(enum EDTSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
    
#elif EDTUserInfoTwo
    
    [self.bridge createSetting:self hasSpace:true settingAction:^(enum EDTSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#elif EDTUserInfoThree
    
    [self.bridge createSetting:self hasPlace:true settingAction:^(enum EDTSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#endif
    
    [self updateCache];
}

- (void)updateTableData {
    
    [self.bridge updateTableData:true];
    
    [self updateCache];
}
- (void)configOwnProperties {
    
#if EDTUserInfoOne
    [super configOwnProperties];
#elif EDTUserInfoTwo
    [super configOwnProperties];
#elif EDTUserInfoThree
    [super configOwnProperties];
#endif
    
}
- (void)updateCache {
    
    NSString *cache = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0];
    
    [self.bridge updateCache:cache];
}
- (void)configNaviItem {
    
    self.title = @"设置";
}
- (BOOL)canPanResponse {
    
    return true;
}

@end
