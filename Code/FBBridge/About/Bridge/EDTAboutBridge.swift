//
//  EDTAboutBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTTable
import RxDataSources
import EDTCocoa

@objc (EDTAboutBridge)
public final class EDTAboutBridge: EDTBaseBridge {
    
    typealias Section = EDTSectionModel<(), EDTAboutType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: EDTAboutViewModel!
}

extension EDTAboutBridge {
    
    @objc public func createAbout(_ vc: EDTTableNoLoadingViewController ,hasSpace: Bool) {
        
        let input = EDTAboutViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(EDTAboutType.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              hasSpace: hasSpace)
        
        viewModel = EDTAboutViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(EDTAboutBean.createAbout(item, title: item.title, subTitle: item.subtitle), for: ip) })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                vc.tableViewSelectData(EDTAboutBean.createAbout(item, title: item.title, subTitle: item.subtitle), for: ip)
            })
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
}
extension EDTAboutBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}
