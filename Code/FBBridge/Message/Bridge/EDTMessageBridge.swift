//
//  EDTMessageBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/20.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTCollection
import RxDataSources
import EDTCocoa
import RxCocoa
import RxSwift
import EDTBean

public typealias EDTMessageAction = (_ ip: IndexPath,_ message: EDTMessageBean) -> ()

@objc (EDTMessageBridge)
public final class EDTMessageBridge: EDTBaseBridge {
    
    typealias Section = EDTAnimationSetionModel<EDTMessageBean>
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: EDTMessageViewModel!
    
    weak var vc: EDTCollectionLoadingViewController!
    
}

extension EDTMessageBridge {
    
    @objc public func createMessage(_ vc: EDTCollectionLoadingViewController ,messageAction: @escaping EDTMessageAction ) {
        
        self.vc = vc
        
        let input = EDTMessageViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(EDTMessageBean.self),
                                                itemSelect: vc.collectionView.rx.itemSelected,
                                                headerRefresh: vc.collectionView.mj_header!.rx.EDTRefreshing.asDriver())
        
        viewModel = EDTMessageViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
        viewModel
            .output
            .collectionData
            .asDriver()
            .map({ $0.map({ Section(header: "\($0.mid)", items: [$0]) }) })
            .drive(vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (message,ip) in
                
                messageAction(ip,message)
            })
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_header!.rx.EDTEndRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { (res) in
                switch res {
                case .fetchList:
                    vc.loadingStatus = .succ
                    
                case .failed:
                    vc.loadingStatus = .fail
                    
                case .empty:
                    vc.loadingStatus = .succ
                    
                    vc.collectionEmptyShow()
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func messageRead(_ ip: IndexPath) {
        
        guard let datasource = dataSource else { return }
        
        let message = datasource[ip]
        
        message.isread = true
        
        vc.collectionView.reloadItems(at: [ip])
    }
}
extension EDTMessageBridge: UITableViewDelegate {
    
    @objc public func messageReadReq(_ message: EDTMessageBean ,_ ip: IndexPath) {
        
        EDTMessageViewModel
            .messageRead("\(message.mid)")
            .drive(onNext: { [unowned self] (result) in
                
                switch result {
                case .ok:
                    
                    self.messageRead(ip)
                default:
                    
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func fetchFirstMessage(_ messageAction: @escaping (_ message: EDTMessageBean) -> ()) {
        
        EDTMessageViewModel
            .fetchFirstMessage()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchList(let list):
                    
                    if list.count > 0{
                        
                        messageAction(list.first as! EDTMessageBean)
                    }
                default:
                    
                    break
                }
            })
            .disposed(by: disposed)
    }
}
