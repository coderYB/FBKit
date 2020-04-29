//
//  FBYY.h
//  FBYY
//
//  Created by 王磊 on 2020/4/28.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBYY.
FOUNDATION_EXPORT double FBYYVersionNumber;

//! Project version string for FBYY.
FOUNDATION_EXPORT const unsigned char FBYYVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBYY/PublicHeader.h>

NS_ASSUME_NONNULL_BEGIN

@class YYCache;

NS_SWIFT_NAME(FBYY)
@interface FBYY : NSObject

+ (instancetype)shared;

@property (nonatomic ,strong , readonly) YYCache *cache;

- (void)createCache:(NSString *)name;

- (void)saveObj:(id<NSCoding>)obj withKey:(NSString *)key;

- (nullable id <NSCoding>)fetchObj:(NSString *)key;

- (BOOL)checkEnv;

@end

NS_ASSUME_NONNULL_END
