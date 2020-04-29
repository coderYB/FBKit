//
//  ZModifyPwdViewModel.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTObservableMapper
import EDTError
import EDTResult
import EDTApi
import EDTRReq
import EDTCheck

public struct EDTModifyPasswordViewModel: EDTViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        /* 旧密码 序列*/
        let oldpassword: Driver<String>
        /* 新密码 序列*/
        let password:Driver<String>
        /* 重复新密码 序列*/
        let passwordAgain:Driver<String>
        
        let completeTaps: Signal<Void>
    }
    
    public struct WLOutput {
        
        let completing: Driver<Void>
        
        let completed: Driver<EDTResult>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let opa = Driver.combineLatest(input.oldpassword, input.password ,input.passwordAgain)
        
        let completing: Driver<Void> = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<EDTResult> = input
            .completeTaps
            .withLatestFrom(opa)
            .flatMapLatest {
                
                switch EDTCheckPasswordModify($0.0, password: $0.2, passwordAgain: $0.1) {
                case .ok: return EDTVoidResp(EDTApi.modifyPassword($0.0, password: $0.1))
                    .map({ EDTResult.ok("修改密码成功") })
                    .asDriver(onErrorRecover: { return Driver.just(EDTResult.failed(($0 as! EDTError).description.0)) })
                    
                case let .failed(message: msg): return Driver<EDTResult>.just(EDTResult.failed( msg))
                default: return Driver<EDTResult>.empty()
                    
                }
        }
        
        self.output = WLOutput( completing: completing, completed: completed)
    }
}

