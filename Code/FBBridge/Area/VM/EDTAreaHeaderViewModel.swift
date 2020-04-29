//
//  EDTAreaHeaderViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTBean

@objc (EDTAreaHeaderBean)
public class EDTAreaHeaderBean: NSObject {
    
    @objc public var isSelected: Bool = false
    
    @objc public var areaBean: EDTAreaBean!
}


struct EDTAreaHeaderViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTAreaHeaderBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(EDTAreaHeaderBean,IndexPath)>
        
        let tableData: BehaviorRelay<[EDTAreaHeaderBean]> = BehaviorRelay<[EDTAreaHeaderBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        self.output = output
    }
}
