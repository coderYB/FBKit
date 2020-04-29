//
//  EDTNameBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTBase
import EDTHud
import EDTBean
import RxCocoa
import EDTCache
import RxSwift

@objc(EDTNameActionType)
public enum EDTNameActionType: Int ,Codable {
    
    case name = 0
    
    case back = 1
}

public typealias EDTNameAction = (_ action: EDTNameActionType ) -> ()

@objc (EDTNameBridge)
public final class EDTNameBridge: EDTBaseBridge {
    
    var viewModel: EDTNameViewModel!
    
    let nickname: BehaviorRelay<String> = BehaviorRelay<String>(value: EDTUserInfoCache.default.userBean.nickname)
}

extension EDTNameBridge {
    
    @objc public func createName(_ vc: EDTBaseViewController ,nameAction: @escaping EDTNameAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let name = vc.view.viewWithTag(201) as? UITextField ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton{
            
            let inputs = EDTNameViewModel.WLInput(orignal: nickname.asDriver(),
                                                       updated: name.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            name.text = nickname.value
            
            viewModel = EDTNameViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    name.resignFirstResponder()
                    
                    EDTHud.show(withStatus: "修改昵称中...")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    EDTHud.pop()
                    
                    switch result {
                    case let .updateUserInfoSucc(_, msg: msg):
                        
                        EDTHud.showInfo(msg)
                        
                        nameAction(.name)
                        
                    case let .failed(msg):
                        
                        EDTHud.showInfo(msg)
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
            
            backItem
                .rx
                .tap
                .subscribe(onNext: { (_) in
                    
                    nameAction(.back)
                })
                .disposed(by: disposed)
        }
    }
}
