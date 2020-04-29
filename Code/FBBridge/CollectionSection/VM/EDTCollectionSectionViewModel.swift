//
//  EDTCollectionSectionViewModel.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import EDTViewModel
import RxSwift
import RxCocoa

@objc (EDTCollectionSectionBean)
public final class EDTCollectionSectionBean: NSObject {
    
    @objc public var sTag: Int = 0
    
    @objc public var items: [EDTCollectionItemBean] = []
    
    @objc public var title: String = ""
    
    @objc public static func createSection(_ sTag: Int,title: String ,items: [EDTCollectionItemBean]) -> EDTCollectionSectionBean {
        
        let section = EDTCollectionSectionBean()
        
        section.sTag = sTag
        
        section.title = title
        
        section.items += items
        
        return section
    }
    private override init() { }
}

@objc (EDTCollectionItemBean)
public final class EDTCollectionItemBean: NSObject {
    
    @objc public var iTag: Int = 0
    
    @objc public var title: String = ""
    
    @objc public var icon: String = ""
    
    @objc public var isSelected: Bool = false
    
    @objc public var placeholder: String = ""
    
    @objc public var value: String = ""
    
    @objc public static func createItem(_ iTag: Int,title: String ,icon: String) -> EDTCollectionItemBean {
        
        return EDTCollectionItemBean .createItem(iTag, title: title, icon: icon, isSelected: false, placeholder: "")
    }
    @objc public static func createItem(_ iTag: Int,title: String ,icon: String,isSelected: Bool ,placeholder: String) -> EDTCollectionItemBean {
        
        let item = EDTCollectionItemBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        item.placeholder = placeholder
        
        item.isSelected = isSelected
        
        return item
    }
    
    private override init() { }
}

struct EDTCollectionSectionViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTCollectionItemBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let sections: [EDTCollectionSectionBean]
    }
    
    struct WLOutput {
        // 获取轮播图序列
        let zip: Observable<(EDTCollectionItemBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[EDTCollectionSectionBean]> = BehaviorRelay<[EDTCollectionSectionBean]>(value:[])
    }
    
    init(_ input: WLInput ) {
        
        self.input = input
        
        output = WLOutput(zip: Observable.zip(input.modelSelect,input.itemSelect))
        
        output.collectionData.accept(input.sections)
    }
}
