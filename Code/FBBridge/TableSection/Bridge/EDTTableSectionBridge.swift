//
//  EDTTableSectionBridge.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import EDTTable
import RxCocoa
import RxSwift
import RxDataSources
import EDTCocoa

public typealias EDTTableSectionAction = (_ item: EDTTableRowBean ,_ ip: IndexPath) -> ()

@objc (EDTTableSectionBridge)
public final class EDTTableSectionBridge: EDTBaseBridge {
    
    var viewModel: EDTTableSectionViewModel!
    
    typealias Section = EDTSectionModel<EDTTableSectionBean, EDTTableRowBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var vc: EDTTableNoLoadingViewController!
    
}

extension EDTTableSectionBridge {
    
    @objc public func createTableSection(_ vc: EDTTableNoLoadingViewController ,sections: [EDTTableSectionBean],sectionAction: @escaping EDTTableSectionAction ) {
        
        self.vc = vc
        
        let input = EDTTableSectionViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(EDTTableRowBean.self),
                                                     itemSelect: vc.tableView.rx.itemSelected,
                                                     sections: sections)
        
        viewModel = EDTTableSectionViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip) },
            titleForHeaderInSection: { ds ,section in return self.viewModel.output.tableData.value[section].title})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .map({ $0.map({ Section(model: $0, items: $0.items) }) })
            .bind(to: vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in
                
                sectionAction(item, ip)
            })
            .disposed(by: disposed)
        
        vc.tableView.rx.setDelegate(self).disposed(by: disposed)
        
    }
}
extension EDTTableSectionBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return vc.caculate(forCell: dataSource[indexPath], for: indexPath)
    }
}
