//
//  EDTBlackBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTTable
import RxDataSources
import EDTCocoa
import EDTBean
import EDTHud

public typealias EDTBlackAction = (_ blackBean: EDTBlackBean ,_ ip: IndexPath) -> ()

@objc (EDTBlackBridge)
public final class EDTBlackBridge: EDTBaseBridge {
    
    typealias Section = EDTAnimationSetionModel<EDTBlackBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    public var viewModel: EDTBlackViewModel!
    
    weak var vc: EDTTableLoadingViewController!
    
    var blackAction: EDTBlackAction!
}
extension EDTBlackBridge {
    
    @objc public func createBlack(_ vc: EDTTableLoadingViewController ,_ blackAction:@escaping EDTBlackAction) {
        
        self.blackAction = blackAction
        
        self.vc = vc
        
        vc.tableView.mj_footer?.isHidden = true
        
        let input = EDTBlackViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(EDTBlackBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              headerRefresh: vc.tableView.mj_header!.rx.EDTRefreshing.asDriver())
        
        viewModel = EDTBlackViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip) }
            ,canEditRowAtIndexPath: { _,_ in return true })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.identity, items: [$0]) }) })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(vc.tableView.mj_header!.rx.EDTEndRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { (res) in
                switch res {
                case .fetchList:
                    vc.loadingStatus = .succ
                case let .failed(msg):
                    EDTHud.showInfo(msg)
                    vc.loadingStatus = .fail
                    
                case .empty:
                    vc.loadingStatus = .succ
                    
                    vc.tableViewEmptyShow()
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in })
            .disposed(by: disposed)
        
        vc.tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
}
extension EDTBlackBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            self.blackAction(self.dataSource[indexPath], ip)
            
        }
        
        let cancel = UITableViewRowAction(style: .default, title: "取消") { (a, ip) in
            
        }
        
        return [cancel,delete]
    }
    
    @objc public func removeBlack(_ blackBean: EDTBlackBean ,_ ip: IndexPath ,_ blackAction: @escaping () -> ()) {
        
        EDTHud.show(withStatus: "移除\(blackBean.users.nickname)中...")
        
        EDTBlackViewModel
            .removeBlack(blackBean.identity)
            .drive(onNext: { [weak self] (result) in
                
                guard let `self` = self else { return }
                
                switch result {
                case .ok:
                    
                    EDTHud.pop()
                    
                    EDTHud.showInfo("移除\(blackBean.users.nickname)成功")
                    
                    var value = self.viewModel.output.tableData.value
                    
                    value.remove(at: ip.section)
                    
                    self.viewModel.output.tableData.accept(value)
                    
                    if value.isEmpty {
                        
                        self.vc.tableViewEmptyShow()
                    }
                    
                    blackAction()
                    
                case .failed:
                    
                    EDTHud.pop()
                    
                    EDTHud.showInfo("移除\(blackBean.users.nickname)失败")
                    
                default: break
                    
                }
            })
            .disposed(by: self.disposed)
    }
    
}
