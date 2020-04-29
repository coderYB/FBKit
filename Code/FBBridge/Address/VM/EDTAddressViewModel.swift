//
//  EDTAddressViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/20.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTResult
import EDTApi
import EDTBean
import EDTRReq
import EDTObservableMapper
import EDTError


struct EDTAddressViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTAddressBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let itemAccessoryButtonTapped: Driver<IndexPath>
        
        let addItemTaps: Signal<Void>
    }
    
    struct WLOutput {
        
        let zip: Observable<(EDTAddressBean,IndexPath)>
        
        let tableData: BehaviorRelay<[EDTAddressBean]> = BehaviorRelay<[EDTAddressBean]>(value: [])
        
        let endHeaderRefreshing: Driver<EDTResult>
        
        let addItemed: Driver<Void>
        
        let itemAccessoryButtonTapped: Driver<IndexPath>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                return EDTArrayResp(EDTApi.fetchAddress)
                    .mapArray(type: EDTAddressBean.self)
                    .map({ return $0.count > 0 ? EDTResult.fetchList($0) : EDTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
            })
        
        let itemAccessoryButtonTapped: Driver<IndexPath> = input.itemAccessoryButtonTapped.map { $0 }
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let addItemed: Driver<Void> = input.addItemTaps.flatMap { Driver.just($0) }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, addItemed: addItemed, itemAccessoryButtonTapped: itemAccessoryButtonTapped)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.tableData.accept(items as! [EDTAddressBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension EDTAddressViewModel {
    
    static func removeAddress(_ encode: String) -> Driver<EDTResult> {
        
        return EDTVoidResp(EDTApi.deleteAddress(encode))
            .flatMapLatest({ return Driver.just(EDTResult.ok("移除成功")) })
            .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
    }
}
