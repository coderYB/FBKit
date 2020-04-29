//
//  EDTRegBridge.swift
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

@objc(EDTRegActionType)
public enum EDTRegActionType: Int ,Codable {
    
    case backLogin = 0
    
    case regSucc = 1
    
    case privacy = 2
}

public typealias EDTRegAction = (_ action: EDTRegActionType ) -> ()

@objc (EDTRegBridge)
public final class EDTRegBridge: EDTBaseBridge {
    
    public var viewModel: EDTRegViewModel!
}

// MARK: 201 手机号 202 密码 203 登陆按钮 204 快捷登录按钮 205 忘记密码按钮 206
extension EDTRegBridge {
    
    @objc public func createReg(_ vc: EDTBaseViewController ,regAction: @escaping EDTRegAction) {
        
        if let phone = vc.view.viewWithTag(201) as? UITextField ,let vcode = vc.view.viewWithTag(202) as? UITextField ,let vcodeItem = vcode.rightView as? UIButton ,let loginItem = vc.view.viewWithTag(203) as? UIButton
            , let backLoginItem = vc.view.viewWithTag(204) as? UIButton ,let proItem = vc.view.viewWithTag(205) as? UIButton {
            
            let input = EDTRegViewModel.WLInput(username: phone.rx.text.orEmpty.asDriver(),
                                              vcode: vcode.rx.text.orEmpty.asDriver() ,
                                              loginTaps: loginItem.rx.tap.asSignal(),
                                              verifyTaps: vcodeItem.rx.tap.asSignal(),
                                              backLoginTaps: backLoginItem.rx.tap.asSignal(),
                                              proTaps: proItem.rx.tap.asSignal())
            
            viewModel = EDTRegViewModel(input, disposed: disposed)
            // 返回序列
            backLoginItem
                .rx
                .tap
                .subscribe({ (_) in
                    
                    regAction(.backLogin)
                })
                .disposed(by: disposed)
            
            // MARK: 登录点击中序列
            viewModel
                .output
                .logining
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    EDTHud.show(withStatus: "注册登录中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 登录事件返回序列
            viewModel
                .output
                .logined
                .drive(onNext: {
                    
                    EDTHud.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): EDTHud.showInfo(msg)
                        
                    case .logined:
                        
                        EDTHud.showInfo("注册成功")
                        
                        regAction(.regSucc)
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .pro
                .drive(onNext: {(_) in
                    
                    regAction(.privacy)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .verifying
                .drive(onNext: { (_) in
                    
                    vc.view.endEditing(true)
                    
                    EDTHud.show(withStatus: "获取验证码中...")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .smsRelay
                .asObservable()
                .bind(to: vcodeItem.rx.EDTSms)
                .disposed(by: disposed)
            
            viewModel
                .output
                .verifyed
                .drive(onNext: { [unowned self ] result in
                    
                    switch result {
                    case let .failed(message: msg):
                        EDTHud.pop()
                        EDTHud.showInfo(msg)
                    case let .ok(msg):
                        EDTHud.pop()
                        EDTHud.showInfo(msg)
                    case let .smsOk(isEnabled: isEnabled, title: title):
                        
                        self.viewModel.output.smsRelay.accept((isEnabled,title))
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
        }
    }
}
