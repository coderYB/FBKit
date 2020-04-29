//
//  EDTMessageViewModel.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/4/13.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTResult
import EDTApi
import EDTBean
import EDTRReq
import EDTError
import EDTObservableMapper

struct EDTMessageViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTMessageBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
    }
    
    struct WLOutput {
        
        let zip: Observable<(EDTMessageBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[EDTMessageBean]> = BehaviorRelay<[EDTMessageBean]>(value: [])
        
        let endHeaderRefreshing: Driver<EDTResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                return EDTArrayResp(EDTApi.fetchSystemMsg(1))
                    .mapArray(type: EDTMessageBean.self)
                    .map({ return $0.count > 0 ? EDTResult.fetchList($0) : EDTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.collectionData.accept(items as! [EDTMessageBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension EDTMessageViewModel {
    
    static func messageRead(_ encode: String) -> Driver<EDTResult> {
        
        return EDTVoidResp(EDTApi.readMsg(encode))
            .flatMapLatest({ return Driver.just(EDTResult.ok("")) })
            .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
    }
    
    static func fetchFirstMessage() -> Driver<EDTResult> {
        
        return EDTArrayResp(EDTApi.fetchFirstMsg)
            .mapArray(type: EDTMessageBean.self)
            .flatMapLatest({ return Driver.just(EDTResult.fetchList($0)) })
            .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
    }
}
