//
//  EDTAreaJson.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/4/10.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation

@objc (EDTAreaJson)
public final class EDTAreaJsonBridge: EDTBaseBridge { }

extension EDTAreaJsonBridge {
    @objc (fetchAreas)
    public func fetchAreas() {
        
        EDTAreaManager
            .default
            .fetchAreas()
            .drive(onNext: { (result) in
                
                
            })
            .disposed(by: disposed)
    }
}
