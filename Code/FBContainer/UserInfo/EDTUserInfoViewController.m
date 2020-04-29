//
//  EDTUserInfoViewController.m
//  EDTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "EDTUserInfoViewController.h"

@import Masonry;
@import CoreServices;
@import JXTAlertManager;
@import WLToolsKit;
@import SDWebImage;
@import ZDatePicker;
@import EDTCommon;
@import EDTColor;
@import EDTString;

@interface EDTUserInfoTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end
@implementation EDTUserInfoTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @EDTLogoIcon]];
        
        _iconImageView.layer.cornerRadius = 5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.layer.borderWidth = 1;
        
        _iconImageView.layer.borderColor = EDTColorCreate(@EDTProjectColor).CGColor;
    }
    return _iconImageView;
}

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
        
        _subTitleLabel.textColor = EDTColorCreate(@"#666666");
    }
    return _subTitleLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.iconImageView];
}

- (void)setUserInfo:(EDTUserInfoBean *)userInfo {
    
    self.titleLabel.text = userInfo.title;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.bottomLineType = EDTBottomLineTypeNormal;
    
    self.iconImageView.hidden = true;
    
    self.subTitleLabel.text = userInfo.subtitle;
    
    self.subTitleLabel.hidden = false;
    
    switch (userInfo.type) {
        case EDTUserInfoTypeSex:
            
            
            break;
        case EDTUserInfoTypeSpace:
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.subTitleLabel.hidden = true;
            
            break;
        case EDTUserInfoTypeHeader:
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.iconImageView.hidden = false;
            
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",userInfo.subtitle]] placeholderImage:[UIImage imageNamed:@EDTLogoIcon] options:SDWebImageRefreshCached];
            
            self.subTitleLabel.hidden = true;
            
            break;
        case EDTUserInfoTypePhone:
        case EDTUserInfoTypeName:

            if ([NSString EDTValidPhone:userInfo.subtitle]) {
                
                NSString * result = [userInfo.subtitle stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                
                self.subTitleLabel.text = result;
            }
            break;
        case EDTUserInfoTypeBirth:
            
            self.subTitleLabel.text = [userInfo.subtitle componentsSeparatedByString:@" "].firstObject;
            
            break;
        default:
            break;
    }
    
#if EDTUserInfoOne
    
#elif EDTUserInfoTwo
    
#elif EDTUserInfoThree
    
    if (userInfo.type == EDTUserInfoTypeSpace) {
        
        self.backgroundColor = EDTColorCreate(@EDTProjectColor);
    } else {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
#endif
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_centerX);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.width.height.mas_equalTo(60);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface EDTUserInfoViewController ()<UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

@property (nonatomic ,strong) EDTUserInfoBridge *bridge;

@property (nonatomic ,strong) ZDatePicker *picker;

@property (nonatomic ,strong) UIImagePickerController *imagePicker;

@property (nonatomic ,copy) EDTUserInfoBlock block;
@end

@implementation EDTUserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if EDTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createUserInfoWithBlock:(EDTUserInfoBlock )block {
    
    return [[self alloc] initWithUserInfoBlock:block];
}
- (instancetype)initWithUserInfoBlock:(EDTUserInfoBlock )block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIImagePickerController *)imagePicker {
    
    if (!_imagePicker) {
        
        _imagePicker = [UIImagePickerController new];
        
        _imagePicker.allowsEditing = false;
        
        _imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        
        _imagePicker.delegate = self;
    }
    return _imagePicker;
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
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[EDTUserInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@EDTBackground]];
    
    background.frame = self.view.bounds;
    
    self.tableView.backgroundView = background;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTUserInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.userInfo = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [EDTUserInfoBridge new];
    
#if EDTUserInfoOne
    
    [self.bridge createUserInfo:self hasSpace:true];
#elif EDTUserInfoTwo
    [self.bridge createUserInfo:self hasSpace:true];
#elif EDTUserInfoThree
    [self.bridge createUserInfo:self hasPlace:true];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"用户资料";
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    EDTUserInfoBean *userInfo = (EDTUserInfoBean *)data;
    
    switch (userInfo.type) {
        case EDTUserInfoTypeName:
        {
            self.block(EDTUserInfoActionTypeName, self);
            
        }
            break;
        case EDTUserInfoTypeSignature:
        {
            
            self.block(EDTUserInfoActionTypeSignature, self);
        }
            break;
        case EDTUserInfoTypeSex:
        {
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"选择性别" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"男").
                addActionDefaultTitle(@"女");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                }
                else if ([action.title isEqualToString:@"男"]) {
                    
                    [weakSelf.bridge updateUserInfoWithType:EDTUserInfoTypeSex value:@"1" action:^{
                        
                        [weakSelf.bridge updateUserInfo:EDTUserInfoTypeSex value:@"1"];
                    }];
                    
                } else if ([action.title isEqualToString:@"女"]) {
                    
                    [weakSelf.bridge updateUserInfoWithType:EDTUserInfoTypeSex value:@"2" action:^{
                        
                        [weakSelf.bridge updateUserInfo:EDTUserInfoTypeSex value:@"2"];
                        
                    }];
                }
            }];
        }
            break;
        case EDTUserInfoTypeBirth:
        {
            if (!self.picker) {
                
                self.picker = [[ZDatePicker alloc] initWithTextColor:EDTColorCreate(@"#666666") buttonColor:EDTColorCreate(@EDTProjectColor) font:EDTSYSTEMFONT(15) locale:[NSLocale localeWithLocaleIdentifier:@"zh-Hans"] showCancelButton:true];
            }
            
            __weak typeof(self) weakSelf = self;
            
            [self.picker show:@"" doneButtonTitle:@"完成" cancelButtonTitle:@"取消" defaultDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
                
                if (date) {
                    
                    [weakSelf.bridge updateUserInfoWithType:EDTUserInfoTypeBirth value:[NSString stringWithFormat:@"%ld",(NSInteger)date.timeIntervalSince1970] action:^{
                        
                        [weakSelf.bridge updateUserInfo:EDTUserInfoTypeBirth value:[NSString stringWithFormat:@"%ld",(NSInteger)date.timeIntervalSince1970]];
                    }];
                }
            }];
        }
            break;
        case EDTUserInfoTypeHeader:
        {
            
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"选择头像图片" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"相册").
                addActionDefaultTitle(@"相机");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                }
                else if ([action.title isEqualToString:@"相册"]) {
                    
                    weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                    [weakSelf presentViewController:weakSelf.imagePicker animated:true completion:nil];
                    
                } else if ([action.title isEqualToString:@"相机"]) {
                    
                    weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [weakSelf presentViewController:weakSelf.imagePicker animated:true completion:nil];
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    __weak typeof(self) weakSelf = self;
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    if (picker.allowsEditing) {
        
        originalImage = info[UIImagePickerControllerEditedImage];
    }
    
    [self.bridge updateHeader:[UIImage compressImageWithImage:originalImage andMaxLength:500 * 1024] action:^{
        
        [weakSelf.tableView reloadData];
    }];
    
    [picker dismissViewControllerAnimated:true completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)canPanResponse {
    
    return true ;
}

- (void)updateName:(NSString *)name {
    
    [self.bridge updateUserInfo:EDTUserInfoTypeName value:name ];
}
- (void)updateSignature:(NSString *)signature {
    
    [self.bridge updateUserInfo:EDTUserInfoTypeSignature value:signature];
}

@end
