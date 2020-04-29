//
//  EDTCollectionsBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTCollection
import RxDataSources
import EDTCocoa
import EDTBean
import EDTHud
import EDTCache

@objc(EDTCollectionsActionType)
public enum EDTCollectionsActionType: Int ,Codable {
    
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

public typealias EDTCollectionsAction = (_ actionType: EDTCollectionsActionType ,_ circle: EDTCircleBean? ,_ ip: IndexPath?) -> ()

@objc (EDTCollectionsBridge)
public final class EDTCollectionsBridge: EDTBaseBridge {
    
    typealias Section = EDTAnimationSetionModel<EDTCircleBean>
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: EDTCollectionsViewModel!
    
    weak var vc: EDTCollectionLoadingViewController!
}

extension EDTCollectionsBridge {
    
    @objc public func createCollections(_ vc: EDTCollectionLoadingViewController ,moreSection: Bool,isMy: Bool ,tag: String ,collectionsAction: @escaping EDTCollectionsAction) {
        
        self.vc = vc
        
        let input = EDTCollectionsViewModel.WLInput(isMy: isMy,
                                                    modelSelect: vc.collectionView.rx.modelSelected(EDTCircleBean.self),
                                                    itemSelect: vc.collectionView.rx.itemSelected,
                                                    headerRefresh: vc.collectionView.mj_header!.rx.EDTRefreshing.asDriver(),
                                                    footerRefresh: vc.collectionView.mj_footer!.rx.EDTRefreshing.asDriver(),
                                                    tag: tag)
        
        viewModel = EDTCollectionsViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
        if moreSection {
            
            viewModel
                .output
                .collectionData
                .asDriver()
                .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
                .drive(vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
        } else {
            
            viewModel
                .output
                .collectionData
                .map({ [Section(header: "", items: $0)] })
                .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
        }
        
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
                case let .failed(msg):
                    EDTHud.showInfo(msg)
                    vc.loadingStatus = .fail
                    
                case .empty:
                    vc.loadingStatus = .succ
                    
                    vc.collectionEmptyShow()
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_footer!.rx.EDTEndRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (circle,ip) in
                
                collectionsAction(isMy ? .myCircle : .circle, circle, ip)
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: vc.collectionView.mj_footer!.rx.isHidden)
            .disposed(by: disposed)
    }
}

extension EDTCollectionsBridge {
    
    @objc public func insertCollectionData(_ collectionData: EDTCircleBean) {
        
        var values = viewModel.output.collectionData.value
        
        values.insert(collectionData, at: 0)
        
        viewModel.output.collectionData.accept(values)
    }
    
    @objc public func fetchObj(_ ip: IndexPath) -> EDTCircleBean? {
        
        guard let dataSource = dataSource else { return nil }
        
        return dataSource[ip]
    }
    
    @objc public func fetchIp(_ circle: EDTCircleBean) -> IndexPath {
        
        let values = viewModel.output.collectionData.value
        
        if let idx = values.firstIndex(where: { $0.encoded == circle.encoded }) {
            
            return IndexPath(item: 0, section: idx)
        }
        return IndexPath(item: 0, section: 0)
        
    }
    @objc public func converToJson(_ circle: EDTCircleBean) -> [String: Any] {
        
        return circle.toJSON()
    }
    
    @objc public func deleteIp(_ ip: IndexPath,moreSection: Bool) {
        
        var values = self.viewModel.output.collectionData.value
        
        if moreSection {
            
            values.remove(at: ip.section)
        } else {
            
            values.remove(at: ip.row)
        }
        
        self.viewModel.output.collectionData.accept(values)

        if values.isEmpty {

            self.vc.collectionEmptyShow()
        }
    }
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,collectionsAction: @escaping EDTCollectionsAction ) {
        
        if !EDTAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        EDTHud.show(withStatus: "添加黑名单中...")
        
        EDTCollectionsViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    self.vc.collectionView.mj_header!.beginRefreshing()
                    
                    collectionsAction(.black, nil, nil)
                    
                    EDTHud.showInfo(msg)
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool ,collectionsAction: @escaping EDTCollectionsAction ) {
        
        if !EDTAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        EDTHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        EDTCollectionsViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(_):
                    
                    let values = self.viewModel.output.collectionData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encode }) {
                        
                        let circle = values[index]
                        
                        circle.isattention = !circle.isattention
                        
                        self.viewModel.output.collectionData.accept(values)
                        
                        collectionsAction(.focus, circle,nil)
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
    
    @objc public func operation(_ encoded: String ,isLike: Bool ,status: String ,aMsg: String,collectionsAction: @escaping () -> () ) {
        
        EDTHud.show(withStatus: status)
        
        EDTCollectionsViewModel
            .like(encoded, isLike: isLike)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(_):
                    
                    collectionsAction()
                    
                    EDTHud.showInfo(aMsg)
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func like(_ encoded: String ,isLike: Bool ,collectionsAction: @escaping EDTCollectionsAction) {
        
        if !EDTAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        EDTHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        EDTCollectionsViewModel
            .like(encoded, isLike: isLike)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    let values = self.viewModel.output.collectionData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encoded }) {
                        
                        let circle = values[index]
                        
                        circle.isLaud = !circle.isLaud
                        
                        if isLike { circle.countLaud -= 1 }
                        else { circle.countLaud += 1}
                        
                        self.viewModel.output.collectionData.accept(values)
                        
                        collectionsAction(.like, circle,nil)
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
    
    @objc public func removeMyCircle(_ encoded: String ,ip: IndexPath,collectionsAction: @escaping EDTCollectionsAction)  {
        
        EDTHud.show(withStatus: "移除内容中...")
        
        EDTCollectionsViewModel
            .removeMyCircle(encoded)
            
            .drive(onNext: { [weak self] (result) in
                
                guard let `self` = self else { return }
                switch result {
                case .ok:
                    
                    EDTHud.pop()
                    
                    EDTHud.showInfo("移除当前内容成功")
                    
                    var value = self.viewModel.output.collectionData.value
                    
                    let circle = value[ip.row]
                    
                    value.remove(at: ip.row)
                    
                    self.viewModel.output.collectionData.accept(value)
                    
                    if value.isEmpty {
                        
                        self.vc.collectionEmptyShow()
                    }
                    
                    collectionsAction(.remove, circle, ip)
                case .failed:
                    
                    EDTHud.pop()
                    
                    EDTHud.showInfo("移除当前内容失败")
                    
                default: break
                    
                }
            })
            .disposed(by: self.disposed)
    }
}
