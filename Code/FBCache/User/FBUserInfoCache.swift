//
//  EDTUserInfoCache.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTBean
import EDTYY

@objc (EDTUserInfoCache)
public final class EDTUserInfoCache: NSObject {
    @objc (shared)
    public static let `default`: EDTUserInfoCache = EDTUserInfoCache()
    
    private override init() {
        
        if let info = Bundle.main.infoDictionary {
            
            EDTYY.shared().createCache(info["CFBundleDisplayName"] as? String ?? "EDTUserInfoCache" )
        }
    }
    @objc (userBean)
    public dynamic var userBean: EDTUserBean = EDTUserBean()
}

extension EDTUserInfoCache {
    
    public func saveUser(data: EDTUserBean) -> EDTUserBean {
        
        if EDTAccountCache.default.uid != "" {
            
            EDTYY.shared().saveObj(data, withKey: "user_" + EDTAccountCache.default.uid)
            
            userBean = data
        }
        
        return data
    }
    
    @objc public func queryUser() -> EDTUserBean  {
        
        if EDTAccountCache.default.uid != "" {
            
            if let user = EDTYY.shared().fetchObj("user_" + EDTAccountCache.default.uid) {
                
                userBean = user as! EDTUserBean
                
                return userBean
            }
        }
        
        return EDTUserBean()
    }
}
