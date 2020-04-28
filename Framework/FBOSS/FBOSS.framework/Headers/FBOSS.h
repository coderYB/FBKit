//
//  FBOSS.h
//  FBOSS
//
//  Created by 王磊 on 2020/4/28.
//  Copyright © 2020 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for FBOSS.
FOUNDATION_EXPORT double FBOSSVersionNumber;

//! Project version string for FBOSS.
FOUNDATION_EXPORT const unsigned char FBOSSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FBOSS/PublicHeader.h>


NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FBOSS)
@interface FBOSS : NSObject

+ (instancetype)shared NS_SWIFT_NAME(shared());

- (void)uploadData:(NSData *)data
     andProjectKey:(NSString *)projectKey
    andAccessKeyId:(NSString *)accessKeyId
andAccessKeySecret:(NSString *)accessKeySecret
  andSecurityToken:(NSString *)securityToken
       andProgress:(void (^) (int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectFBoSend))progress
           andSucc:(void (^)(NSString * _Nonnull))succ
           andFail:(void (^)(NSError * _Nonnull))fail;

@end

NS_ASSUME_NONNULL_END
