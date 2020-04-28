//
//  NSString+FB.h
//  FBString
//
//  Created by 王磊 on 2020/4/25.
//  Copyright © 2020 王磊. All rights reserved.
//


@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FBQR)

+ (CIImage *)createQRCodeWithUrlString:(NSString *)urlString;

+ (UIImage *)createNonInterpolatedUIImageWithCIImage:(CIImage *)image
                                             andSize:(CGFloat) size;

@end

@interface NSString (FBEmpty)

- (BOOL)FBEmpty;

//bool FBisEmpty(NSString *argu);

- (BOOL)FBEmptyByTrimming;

@end

@interface NSString (FBValid)
/*
 @param phone
 @result 长度11 首位为1的手机号为真
 */
+ (BOOL)FBValidPhone:(NSString *)phone;

- (BOOL)FBValidPhone;

/*
 @param email
 @result 正则表达式
 */
+ (BOOL)FBValidEmail:(NSString *)email;

- (BOOL)FBValidEmail;


@end

typedef NS_ENUM(NSInteger ,FBDateType) {

    FBDateTypeFull , // yyyy-MM-dd hh:mm:ss

    FBDateTypeLong, // yyyy-MM-dd hh:mm

    FBDateTypeDate  // 下一个是时间 几分钟前。。 昨天 几天前
};

@interface NSString (FBDateConvert)

- (NSString *)FBConvertToDate;

- (NSString *)FBConvertToDate:(FBDateType )type;


@end
NS_ASSUME_NONNULL_END
