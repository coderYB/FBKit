//
//  EDTCollectionsViewModel.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTResult
import EDTBean
import EDTRReq
import EDTApi
import EDTError

struct EDTCollectionsViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let isMy: Bool
        
        let modelSelect: ControlEvent<EDTCircleBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let footerRefresh: Driver<Void>
        
        let page: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
        
        let tag: String
    }
    
    struct WLOutput {
        
        let zip: Observable<(EDTCircleBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[EDTCircleBean]> = BehaviorRelay<[EDTCircleBean]>(value: [])
        
        let endHeaderRefreshing: Driver<EDTResult>
        
        let endFooterRefreshing: Driver<EDTResult>
        
        let footerHidden: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .flatMapLatest({_ in
  
                return EDTArrayResp(input.isMy ? EDTApi.fetchMyList(input.tag, page: 1) : EDTApi.fetchList(input.tag, page: 1))
                    .mapArray(type: EDTCircleBean.self)
                    .map({ return $0.count > 0 ? EDTResult.fetchList($0) : EDTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let footerRefreshData = input
            .footerRefresh
            .flatMapLatest({_ in
                
                return EDTArrayResp(input.isMy ? EDTApi.fetchMyList(input.tag, page: input.page.value) : EDTApi.fetchList(input.tag, page: input.page.value))
                    .mapArray(type: EDTCircleBean.self)
                    .map({ return $0.count > 0 ? EDTResult.fetchList($0) : EDTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
            })
        
        let endFooterRefreshing = footerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, endFooterRefreshing: endFooterRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    if !items.isEmpty {
                        
                        input.page.accept(2)
                        
                        if items.count < 20 {
                            
                            output.footerHidden.accept(true)
                            
                            input.page.accept(1)
                        } else {
                            
                            output.footerHidden.accept(false)
                        }
                    } else {
                        
                        input.page.accept(1)
                        
                        output.footerHidden.accept(true)
                    }
                    
                    output.collectionData.accept(items as! [EDTCircleBean])
                    
                case .empty: output.collectionData.accept([])
                default: break
                }
            })
            .disposed(by: disposed)
        
        footerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    if !items.isEmpty {
                        
                        var page = input.page.value
                        
                        page += 1
                        
                        input.page.accept(page)
                        
                        if items.count < 20 {
                            
                            output.footerHidden.accept(true)
                            
                        } else {
                            
                            output.footerHidden.accept(false)
                        }
                    } else {
                        
                        output.footerHidden.accept(true)
                    }
                    
                    var values = output.collectionData.value
                    
                    values += items as! [EDTCircleBean]
                    
                    output.collectionData.accept(values )
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
    
    static func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String) -> Driver<EDTResult> {

        return EDTVoidResp(EDTApi.addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content))
            .map({ _ in EDTResult.ok("添加黑名单成功")})
            .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
    }
    static func focus(_ uid: String ,encode: String) -> Driver<EDTResult> {
        
        return EDTVoidResp(EDTApi.focus(uid, targetEncoded: encode))
            .flatMapLatest({ return Driver.just(EDTResult.ok("关注或取消关注成功")) })
            .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
    }
    
    static func like(_ encoded: String ,isLike: Bool) -> Driver<EDTResult> {
        
        return EDTVoidResp(EDTApi.like(encoded))
            .flatMapLatest({ return Driver.just(EDTResult.ok( isLike ? "点赞成功" : "取消点赞成功")) })
            .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
    }
    static func removeMyCircle(_ encoded: String ) -> Driver<EDTResult> {
        
        return EDTVoidResp(EDTApi.deleteMyCircle(encoded))
            .map({ EDTResult.ok("删除成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
    }
}
