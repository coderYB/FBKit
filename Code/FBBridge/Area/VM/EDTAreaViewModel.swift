//
//  EDTAreaViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/13.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTBean

struct EDTAreaViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let areas: [EDTAreaBean]
        
        let modelSelect: ControlEvent<EDTAreaBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(EDTAreaBean,IndexPath)>
        
        let tableData: BehaviorRelay<[EDTAreaBean]> = BehaviorRelay<[EDTAreaBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        output.tableData.accept(input.areas)
        
        self.output = output
    }
}
