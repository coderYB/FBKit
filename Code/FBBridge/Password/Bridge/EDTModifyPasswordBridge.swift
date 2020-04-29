//
//  EDTModifyPwdBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTBase
import EDTHud
import RxCocoa
import RxSwift
import EDTCocoa

public typealias EDTModifyPasswordAction = () -> ()

@objc (EDTModifyPasswordBridge)
public final class EDTModifyPasswordBridge: EDTBaseBridge {
    
    public var viewModel: EDTModifyPasswordViewModel!
}
// MARK:  旧密码201 新密码 202 确认密码 203 修改密码
extension EDTModifyPasswordBridge {
    
    @objc public func createPassword(_ vc: EDTBaseViewController ,passwordAction: @escaping EDTModifyPasswordAction) {
        
        if let oldpassword = vc.view.viewWithTag(201) as? UITextField ,let password = vc.view.viewWithTag(202) as? UITextField ,let passwordAgain = vc.view.viewWithTag(203) as? UITextField ,let completeItem = vc.view.viewWithTag(204) as? UIButton {
            
            let input = EDTModifyPasswordViewModel.WLInput(oldpassword: oldpassword.rx.text.orEmpty.asDriver(),
                                                           password: password.rx.text.orEmpty.asDriver() ,
                                                           passwordAgain: passwordAgain.rx.text.orEmpty.asDriver(),
                                                           completeTaps: completeItem.rx.tap.asSignal())
            
            viewModel = EDTModifyPasswordViewModel(input, disposed: disposed)
            
            // MARK: 修改密码 点击
            viewModel
                .output
                .completing
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    EDTHud.show(withStatus: "修改密码中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 修改密码 完成
            viewModel
                .output
                .completed
                .drive(onNext: {
                    
                    EDTHud.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): EDTHud.showInfo(msg)
                        
                    case let .ok(msg):
                        
                        EDTHud.showInfo(msg)
                        
                        passwordAction()
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
        }
    }
}
