//
//  EDTAreaManager.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTBean
import EDTYY
import RxCocoa
import EDTResult
import RxSwift
import EDTReq
import EDTApi
import Alamofire
import EDTRReq
import EDTObservableMapper
import EDTError

@objc (EDTAreaManager)
public class EDTAreaManager: NSObject {
    
    @objc (shared)
    public static let `default`: EDTAreaManager = EDTAreaManager()
    
    private override init() { }
    // 全部地区
    @objc public var allAreas: [EDTAreaBean] = []
}

extension EDTAreaManager {
    
      public func fetchAreas() -> Driver<EDTResult> {
        
        if allAreas.count > 0 {
            
            return Driver.just(EDTResult.fetchList(allAreas))
        } else {
            
            if isAreaFileExist() {
                
                let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
                
                let targetPath = cachePath + "/Areas"
                
                if let arr = NSArray(contentsOfFile: targetPath) {
                    
                    var mutable: [EDTAreaBean] = []
                    
                    for item in arr {
                        
                        mutable += [EDTAreaBean(JSON: item as! [String: Any])!]
                    }
                    
                    allAreas += mutable
                    
                    return Driver.just(EDTResult.fetchList(mutable))
                }
                
                return Driver.just(EDTResult.failed("获取本地数据失败!"))
            } else {
                
                return EDTAreaResp(EDTApi.fetchAreaJson)
                    .map({ EDTAreaManager.default.saveArea($0) })
                    .map({ _ in EDTResult.fetchList(EDTAreaManager.default.allAreas)  })
                    .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
            }
        }
    }
    
   @objc public func fetchSomeArea(_ id: Int)  -> EDTAreaBean {
        
        assert(allAreas.count > 0, "请先调用 fetchArea")
        
        var result: EDTAreaBean!
        
        for item in allAreas {
            
            if item.areaId == id {
                
                result = item
                
                break
            }
        }
        
        return result ?? EDTAreaBean()
    }
    
   @objc public func saveArea(_ areas: [Any]) -> [Any] {
        
        for item in areas {
            
            allAreas += [EDTAreaBean(JSON: item as! [String: Any])!]
        }
        
        let mutable = NSMutableArray()
        
        mutable.addObjects(from: areas)
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        mutable.write(toFile: targetPath, atomically: true)
        
        return areas
    }
    
    public func isAreaFileExist() -> Bool {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        return FileManager.default.fileExists(atPath: targetPath)
    }
}
