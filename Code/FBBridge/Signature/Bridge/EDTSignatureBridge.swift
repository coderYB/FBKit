//
//  EDTSignatureBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import EDTBase
import EDTHud
import EDTCache

@objc(EDTSignatureActionType)
public enum EDTSignatureActionType: Int ,Codable {
    
    case signature = 0
    
    case back = 1
}

public typealias EDTSignatureAction = (_ action: EDTSignatureActionType ) -> ()

@objc (EDTSignatureBridge)
public final class EDTSignatureBridge: EDTBaseBridge {
    
    var viewModel: EDTSignatureViewModel!
    
    let signature: BehaviorRelay<String> = BehaviorRelay<String>(value: EDTUserInfoCache.default.userBean.signature)
}

extension EDTSignatureBridge {
    
    @objc public func createSignature(_ vc: EDTBaseViewController ,signatureAction: @escaping EDTSignatureAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let signaturetv = vc.view.viewWithTag(201) as? UITextView ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton ,let placeholder = vc.view.viewWithTag(202) {
            
            let inputs = EDTSignatureViewModel.WLInput(orignal: signature.asDriver(),
                                                       updated: signaturetv.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            signaturetv.text = signature.value
            
            viewModel = EDTSignatureViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    EDTHud.show(withStatus: "修改个性签名...")
                    
                    signaturetv.resignFirstResponder()
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
                        
                        signatureAction(.signature)
                        
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
                    
                    signatureAction(.back)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .placeholderHidden
                .drive(placeholder.rx.isHidden)
                .disposed(by: disposed)
        }
    }
}
