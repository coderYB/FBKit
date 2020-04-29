//
//  EDTCommentBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/9/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTTable
import RxDataSources
import EDTCocoa
import EDTBean
import EDTHud
import MJRefresh

@objc (EDTCommentBridge)
public final class EDTCommentBridge: EDTBaseBridge {
    
    typealias Section = EDTAnimationSetionModel<EDTCommentBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: EDTCommentViewModel!
    
    weak var vc: EDTTableLoadingViewController!
    
    var circleBean: EDTCircleBean!
}
extension EDTCommentBridge {
    
    @objc public func createComment(_ vc: EDTTableLoadingViewController,encode: String ,circle: EDTCircleBean) {
        
        self.vc = vc
        
        self.circleBean = circle
        
        let input = EDTCommentViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(EDTCommentBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              headerRefresh: vc.tableView.mj_header!.rx.EDTRefreshing.asDriver(),
                                              footerRefresh: vc.tableView.mj_footer!.rx.EDTRefreshing.asDriver(),
                                              encoded: encode)
        
        viewModel = EDTCommentViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
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
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(vc.tableView.mj_footer!.rx.EDTEndRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in
                
                vc.tableViewSelectData(type, for: ip)
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: vc.tableView.mj_footer!.rx.isHidden)
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    @objc public func insertComment(_ comment: EDTCommentBean) {
        
        var value = self.viewModel.output.tableData.value
        
        if value.last!.type == .empty {
            
            value.removeLast()
            
            value.insert(comment, at: 2)
            
            self.viewModel.output.tableData.accept(value)
            
        } else if value.last!.type == .failed {
            
            self.vc.tableView.mj_header!.beginRefreshing()
            
        } else {
            
            value.insert(comment , at: 2)
            
            self.viewModel.output.tableData.accept(value)
        }
        
        self.vc.tableView.scrollsToTop = true

    }
    @objc public func addComment(_ encoded: String,content: String ,commentAction: @escaping (_ comment: EDTCommentBean? ,_ circleBean: EDTCircleBean) -> () ) {
        
        EDTHud.show(withStatus: "发布评论中....")
        
        EDTCommentViewModel
            .addComment(encoded, content: content)
            .drive(onNext: { [unowned self](result) in
                
                EDTHud.pop()
                
                switch result {
                case .operation(let comment):
                    
                    EDTHud.showInfo("发布评论成功!")
                    
                    self.circleBean.countComment += 1
                    
                    self.insertComment(comment as! EDTCommentBean)
                    
                    commentAction(comment as? EDTCommentBean ,self.circleBean)

                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}

extension EDTCommentBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
}
