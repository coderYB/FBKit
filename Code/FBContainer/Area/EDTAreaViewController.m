//
//  EDTAreaViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "EDTAreaViewController.h"
@import Masonry;
@import EDTColor;
@import EDTBean;
@import EDTCommon;

@interface EDTAreaTableViewCell : EDTBaseTableViewCell

@property (nonatomic ,strong) EDTAreaBean *areaBean;

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation EDTAreaTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = EDT_LABEL_NEW;
        
        _titleLabel.font = EDTSYSTEMFONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = EDTColorCreate(@"#666666");
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
    
}
- (void)setAreaBean:(EDTAreaBean *)areaBean {
    _areaBean = areaBean;
    
    self.titleLabel.text = areaBean.name;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if (areaBean.isSelected) {
        
        self.titleLabel.textColor = EDTColorCreate(@EDTProjectColor);
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        
        self.titleLabel.textColor = EDTColorCreate(@"#666666");
    }
    
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface EDTAreaViewController()

@property (nonatomic ,assign) EDTAreaType type;

@property (nonatomic ,copy) EDTAreaBlock block;

@property (nonatomic ,strong) EDTAreaBridge *bridge;
@end

@implementation EDTAreaViewController

+ (instancetype)createAreaWithType:(EDTAreaType)type andAreaBlock:(EDTAreaBlock)block {
    
    return [[self alloc] initWithType:type andAreaBlock:block];
}
- (instancetype)initWithType:(EDTAreaType)type andAreaBlock:(EDTAreaBlock)block {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[EDTAreaTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}
- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTAreaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[EDTAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.areaBean = data;
    
    return cell;
}

- (void)selectedArea:(NSInteger )sid andBlock:(EDTAreaBlock)block {
    
    switch (self.type) {
        case EDTAreaTypeProvince:
            
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchCitys:sid].count);
            break;
        case EDTAreaTypeCity:
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchRegions:sid].count);
            break;
        default:
            break;
    }
}
- (void)updateAreas:(NSInteger )sid {
    
    [self.bridge updateDatas:sid areas:@[]];
}
- (void)configViewModel {
    
    self.bridge = [EDTAreaBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createArea:self type:self.type areaAction:^(EDTAreaBean * _Nonnull areaBean, enum EDTAreaType areaType, BOOL hasNext) {
       
        weakSelf.block(weakSelf, areaBean, areaType, hasNext);
    }];

}

- (EDTAreaBean *)fetchAreaWithId:(NSInteger)sid {
    
    return [self.bridge fetchAreaWithId:sid];
}

@end
