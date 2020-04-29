//
//  FBAreaViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "FBAreaViewController.h"
@import Masonry;
@import FBColor;
@import FBBean;
@import FBCommon;

@interface FBAreaTableViewCell : FBBaseTableViewCell

@property (nonatomic ,strong) FBAreaBean *areaBean;

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation FBAreaTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = FB_LABEL_NEW;
        
        _titleLabel.font = FB_SYSTEM_FONT(15);
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = FB_COLOR_CREATE(@"#666666");
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
    
}
- (void)setAreaBean:(FBAreaBean *)areaBean {
    _areaBean = areaBean;
    
    self.titleLabel.text = areaBean.name;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if (areaBean.isSelected) {
        
        self.titleLabel.textColor = FB_COLOR_CREATE(@FBProjectColor);
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        
        self.titleLabel.textColor = FB_COLOR_CREATE(@"#666666");
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

@interface FBAreaViewController()

@property (nonatomic ,assign) FBAreaType type;

@property (nonatomic ,copy) FBAreaBlock block;

@property (nonatomic ,strong) FBAreaBridge *bridge;
@end

@implementation FBAreaViewController

+ (instancetype)createAreaWithType:(FBAreaType)type andAreaBlock:(FBAreaBlock)block {
    
    return [[self alloc] initWithType:type andAreaBlock:block];
}
- (instancetype)initWithType:(FBAreaType)type andAreaBlock:(FBAreaBlock)block {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[FBAreaTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}
- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    FBAreaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[FBAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.areaBean = data;
    
    return cell;
}

- (void)selectedArea:(NSInteger )sid andBlock:(FBAreaBlock)block {
    
    switch (self.type) {
        case FBAreaTypeProvince:
            
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchCitys:sid].count);
            break;
        case FBAreaTypeCity:
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
    
    self.bridge = [FBAreaBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createArea:self type:self.type areaAction:^(FBAreaBean * _Nonnull areaBean, enum FBAreaType areaType, BOOL hasNext) {
       
        weakSelf.block(weakSelf, areaBean, areaType, hasNext);
    }];

}

- (FBAreaBean *)fetchAreaWithId:(NSInteger)sid {
    
    return [self.bridge fetchAreaWithId:sid];
}

@end
