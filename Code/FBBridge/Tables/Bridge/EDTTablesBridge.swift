//
//  EDTTablesBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTTable
import RxDataSources
import EDTCocoa
import EDTBean
import EDTHud
import EDTCache

@objc(EDTTablesActionType)
public enum EDTTablesActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10
}

public typealias EDTTablesAction = (_ actionType: EDTTablesActionType ,_ circle: EDTCircleBean? ,_ ip: IndexPath?) -> ()

@objc (EDTTablesBridge)
public final class EDTTablesBridge: EDTBaseBridge {
    
    typealias Section = EDTAnimationSetionModel<EDTCircleBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: EDTTablesViewModel!
    
    weak var vc: EDTTableLoadingViewController!
    
    var tablesAction: EDTTablesAction!
}
extension EDTTablesBridge {
    
    @objc public func createTables(_ vc: EDTTableLoadingViewController ,isMy: Bool ,tag: String ,tablesAction: @escaping EDTTablesAction) {
        
        self.vc = vc
        
        self.tablesAction = tablesAction
        
        let input = EDTTablesViewModel.WLInput(isMy: isMy,
                                            modelSelect: vc.tableView.rx.modelSelected(EDTCircleBean.self),
                                            itemSelect: vc.tableView.rx.itemSelected,
                                            headerRefresh: vc.tableView.mj_header!.rx.EDTRefreshing.asDriver(),
                                            footerRefresh: vc.tableView.mj_footer!.rx.EDTRefreshing.asDriver(),
                                            tag: tag)
        
        viewModel = EDTTablesViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)},
            canEditRowAtIndexPath: { _,_ in return isMy })
        
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
                    
                    vc.tableViewEmptyShow()
                    
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
                
                tablesAction(isMy ? .myCircle : .circle,type,ip)
                
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
    
    @objc public func updateCircle(_ circle: EDTCircleBean ,ip: IndexPath) {
        
        var values = viewModel.output.tableData.value
        
        values.replaceSubrange(ip.row..<ip.row+1, with: [circle])
        
        viewModel.output.tableData.accept(values)
    }
    
    @objc public func insertCircle(_ circle: EDTCircleBean) {
        
        var values = viewModel.output.tableData.value
        
        values.insert(circle, at: 0)
        
        if values.count == 1 {
            
            vc.tableViewEmptyHidden()
        }
        
        viewModel.output.tableData.accept(values)
    }
}

extension EDTTablesBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            self.tablesAction(.remove,self.dataSource[indexPath] ,indexPath)
        }
        let cancel = UITableViewRowAction(style: .default, title: "取消") { (a, ip) in
    
        }
        
        return [cancel,delete]
    }
}

extension EDTTablesBridge {
    
    @objc public func insertTableData(_ tableData: EDTCircleBean) {
        
        var values = viewModel.output.tableData.value
        
        values.insert(tableData, at: 0)
        
        viewModel.output.tableData.accept(values)
    }
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,tablesAction: @escaping EDTTablesAction) {
        
        if !EDTAccountCache.default.isLogin() {
            
            tablesAction(.unLogin, nil,nil)
            
            return
        }
        
        EDTHud.show(withStatus: "添加黑名单中...")
        
        EDTTablesViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    self.vc.tableView.mj_header!.beginRefreshing()
                    
                    EDTHud.showInfo(msg)
                    
                    tablesAction(.black, nil,nil)
                    
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,tablesAction: @escaping EDTTablesAction) {
        
        if !EDTAccountCache.default.isLogin() {
            
            tablesAction(.unLogin, nil,nil)
            
            return
        }
        
        EDTHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        EDTTablesViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok:
                    
                    let values = self.viewModel.output.tableData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encode }) {
                        
                        let circle = values[index]
                        
                        circle.isattention = !circle.isattention
                        
                        self.viewModel.output.tableData.accept(values)
                        
                        tablesAction(.focus, circle,nil)
                    }
                    
                    EDTHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }
    @objc public func fetchIp(_ circle: EDTCircleBean) -> IndexPath {
        
        let values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.encoded == circle.encoded }) {
            
            return IndexPath(item: 0, section: idx)
        }
        return IndexPath(item: 0, section: 0)
        
    }
    @objc public func fetchSingleData(_ ip: IndexPath) -> EDTCircleBean? {
        
        guard let dataSource = dataSource else { return nil }
        
        return dataSource[ip]
    }
    @objc public func fetchTableDatas() -> [EDTCircleBean] {
        
        return viewModel.output.tableData.value
    }
    
    @objc public func converToJson(_ circle: EDTCircleBean) -> [String: Any] {
        
        return circle.toJSON()
    }
    
    @objc public func like(_ encoded: String,isLike: Bool,tablesAction: @escaping EDTTablesAction) {
        
        if !EDTAccountCache.default.isLogin() {
            
            tablesAction(.unLogin, nil,nil)
            
            return
        }
        
        EDTHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        EDTTablesViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    let values = self.viewModel.output.tableData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encoded }) {
                        
                        let circle = values[index]
                        
                        circle.isLaud = !circle.isLaud
                        
                        if isLike { circle.countLaud -= 1 }
                        else { circle.countLaud += 1}
                        
                        self.viewModel.output.tableData.accept(values)
                        
                        tablesAction(.like, circle,nil)
                    }
                    
                    EDTHud.showInfo(msg)
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func removeMyCircle(_ encoded: String ,ip: IndexPath,tablesAction: @escaping EDTTablesAction )  {
        
        EDTHud.show(withStatus: "移除内容中...")

        EDTTablesViewModel
            .removeMyCircle(encoded)

            .drive(onNext: { [weak self] (result) in

                guard let `self` = self else { return }
                switch result {
                case .ok:

                    EDTHud.pop()

                    EDTHud.showInfo("移除当前内容成功")

                    var value = self.viewModel.output.tableData.value

                    let circle = value[ ip.row]
                    
                    value.remove(at: ip.row)

                    self.viewModel.output.tableData.accept(value)

                    if value.isEmpty {

                        self.vc.tableViewEmptyShow()
                    }
                    
                    tablesAction(.remove, circle, ip)

                case .failed:

                    EDTHud.pop()

                    EDTHud.showInfo("移除当前内容失败")

                default: break

                }
            })
            .disposed(by: self.disposed)
    }
}
