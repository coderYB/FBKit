//
//  FBSettingViewController.m
//  FBContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "FBSettingViewController.h"
@import FBColor;
@import Masonry;
@import SDWebImage;
@import FBCommon;

@interface FBSettingTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UISwitch *swiItem;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end

@implementation FBSettingTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.font = FB_SYSTEM_FONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = FB_COLOR_CREATE(@"#333333");
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = FB_LABEL_NEW;
        
        _subTitleLabel.font = FB_SYSTEM_FONT(15);
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = FB_COLOR_CREATE(@"#999999");
    }
    return _subTitleLabel;
}

- (UISwitch *)swiItem {
    if (!_swiItem) {
        
        _swiItem = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        _swiItem.onTintColor = FB_COLOR_CREATE(@FBProjectColor);
        
        _swiItem.thumbTintColor = [UIColor whiteColor];
    }
    return _swiItem;
}
- (void)setSetting:(FBSettingBean *)setting {
    //    _setting = setting;
    
    self.swiItem.hidden = true;
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.titleLabel.textColor =  FB_COLOR_CREATE(@"#333333");
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.bottomLineType = FBBottomLineTypeNormal;
    
    self.subTitleLabel.hidden = true;
    
    self.subTitleLabel.text = setting.subTitle;
    
    self.backgroundColor = FB_COLOR_CREATE(@"#ffffff");
    
    switch (setting.type) {
        case FBSettingTypeLogout:
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.titleLabel.textColor =  FB_COLOR_CREATE(@FBProjectColor);
            break;
        case FBSettingTypeSpace:
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.bottomLineType = FBBottomLineTypeNone;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
        case FBSettingTypePush:
            
            self.swiItem.hidden = false;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
        case FBSettingTypeClear:
            
            self.subTitleLabel.hidden = false;
            
        default:
            break;
    }
    
    self.titleLabel.text = setting.title;
    
#if FBUserInfoOne
    
#elif FBUserInfoTwo
    
#elif FBUserInfoThree
    
    if (setting.type == FBSettingTypeSpace) {
        
        self.backgroundColor = FB_COLOR_CREATE(@FBProjectColor);
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
@interface FBSettingViewController ()

@property (nonatomic ,strong) FBSettingBridge *bridge;

@property (nonatomic ,copy) FBSettingBlock block;

@end

@implementation FBSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if FBPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createSettingWithBlock:(FBSettingBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(FBSettingBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[FBSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@FBBackground]];
    
    background.frame = self.view.bounds;
    
    self.tableView.backgroundView = background;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.setting = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [FBSettingBridge new];
    
    __weak typeof(self) weakSelf = self;
    
#if FBUserInfoOne
    
    [self.bridge createSetting:self hasSpace:true settingAction:^(enum FBSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
    
#elif FBUserInfoTwo
    
    [self.bridge createSetting:self hasSpace:true settingAction:^(enum FBSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#elif FBUserInfoThree
    
    [self.bridge createSetting:self hasPlace:true settingAction:^(enum FBSettingActionType actionType) {
        
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
    
#if FBUserInfoOne
    [super configOwnProperties];
#elif FBUserInfoTwo
    [super configOwnProperties];
#elif FBUserInfoThree
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
