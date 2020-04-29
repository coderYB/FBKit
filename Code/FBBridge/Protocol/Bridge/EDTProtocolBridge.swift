//
//  EDTProtocolBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTTextInner

@objc (EDTProtocolBridge)
public final class EDTProtocolBridge: EDTBaseBridge {
    
    public var viewModel: EDTProtocolViewModel!
}

extension EDTProtocolBridge {
    
    @objc public func createProtocol(_ vc: EDTTextInnerViewController) {
        
        let inputs = EDTProtocolViewModel.WLInput()
        
        viewModel = EDTProtocolViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: {(value) in
                
                DispatchQueue.main.async {
                    
                    vc.EDTLoadHtmlString(htmlString: value)
                }
                
            })
            .disposed(by: disposed)
    }
}
