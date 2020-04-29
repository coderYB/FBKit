//
//  EDTVideoViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/22.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTResult
import EDTRReq
import EDTApi
import EDTError

struct EDTVideoViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
    }
    
    struct WLOutput {
    
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        self.output = WLOutput()
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
}
