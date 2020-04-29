//
//  EDTCollectionSectionBridge.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import EDTCollection
import RxCocoa
import RxSwift
import RxDataSources
import EDTCocoa

public typealias EDTCollectionSectionAction = (_ item: EDTCollectionItemBean) -> ()

@objc (EDTCollectionSectionBridge)
public final class EDTCollectionSectionBridge: EDTBaseBridge {
    
    var viewModel: EDTCollectionSectionViewModel!
    
    typealias Section = EDTSectionModel<EDTCollectionSectionBean, EDTCollectionItemBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: EDTCollectionNoLoadingViewController!
    
}

// MARK: skip item 101 pagecontrol 102
extension EDTCollectionSectionBridge {
    
    @objc public func createCollectionSection(_ vc: EDTCollectionNoLoadingViewController ,sections: [EDTCollectionSectionBean],sectionAction: @escaping EDTCollectionSectionAction) {
        
        let input = EDTCollectionSectionViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(EDTCollectionItemBean.self),
                                                          itemSelect: vc.collectionView.rx.itemSelected,
                                                          sections: sections)
        
        viewModel = EDTCollectionSectionViewModel(input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip) },
            configureSupplementaryView: { ds, cv, kind, ip in return vc.configCollectionViewHeader(self.viewModel.output.collectionData.value[ip.section], for: ip)})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .collectionData
            .map({ $0.map({ Section(model: $0, items: $0.items) }) })
            .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in

                sectionAction(item)
            })
            .disposed(by: disposed)
        
    }
    
    @objc public func fetchSingleData(_ ip: IndexPath) -> EDTCollectionItemBean! {
        
        guard let dataSource = dataSource else { return nil }
        
        return dataSource[ip]
    }
    
    @objc public func fetchCollectionDatas() -> [EDTCollectionItemBean] {
        
        guard let viewModel = viewModel else { return [] }
        
        var mutable: [EDTCollectionItemBean] = []
        
        for item in viewModel.output.collectionData.value {
            
            mutable += item.items
        }
        
        return mutable
    }
}
