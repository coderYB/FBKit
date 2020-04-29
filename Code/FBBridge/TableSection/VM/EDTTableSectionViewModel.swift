//
//  EDTTableSectionViewModel.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import EDTViewModel
import RxSwift
import RxCocoa

@objc (EDTTableSectionBean)
public final class EDTTableSectionBean: NSObject {
    
    @objc public var sTag: Int = 0
    
    @objc public var items: [EDTTableRowBean] = []
    
    @objc public var title: String = ""
    
    @objc public static func createSection(_ sTag: Int,title: String ,items: [EDTTableRowBean]) -> EDTTableSectionBean {
        
        let section = EDTTableSectionBean()
        
        section.sTag = sTag
        
        section.title = title
        
        section.items += items
        
        return section
    }
    private override init() { }
}

@objc (EDTTableRowBean)
public final class EDTTableRowBean: NSObject {
    
    @objc public var iTag: Int = 0
    
    @objc public var title: String = ""
    
    @objc public var icon: String = ""
    
    @objc public var value: String = ""
    
    @objc public var placeholder: String = ""
    
    @objc public var isSelected: Bool = false
    
    @objc public static func createRow(_ iTag: Int,title: String ,icon: String) -> EDTTableRowBean {
        
        let item = EDTTableRowBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        return item
    }
    @objc public static func createRow(_ iTag: Int,title: String ,icon: String ,isSelected: Bool ,placeholder: String) -> EDTTableRowBean {
        
        let item = EDTTableRowBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        item.isSelected = isSelected
        
        item.placeholder = placeholder
        
        return item
    }
    private override init() { }
}

struct EDTTableSectionViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTTableRowBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let sections: [EDTTableSectionBean]
    }
    
    struct WLOutput {
        // 获取轮播图序列
        let zip: Observable<(EDTTableRowBean,IndexPath)>
        
        let tableData: BehaviorRelay<[EDTTableSectionBean]> = BehaviorRelay<[EDTTableSectionBean]>(value:[])
    }
    
    init(_ input: WLInput ) {
        
        self.input = input
        
        output = WLOutput(zip: Observable.zip(input.modelSelect,input.itemSelect))
        
        output.tableData.accept(input.sections)
    }
}
