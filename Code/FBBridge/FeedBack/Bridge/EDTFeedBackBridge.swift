//
//  EDTFeedBackBridge.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import EDTBase
import EDTHud

public typealias EDTFeedBackAction = () -> ()

@objc (EDTFeedBackBridge)
public final class EDTFeedBackBridge: EDTBaseBridge {
    
    var viewModel: EDTFeedBackViewModel!
}

extension EDTFeedBackBridge {
    
    @objc public func createFeedBack(_ vc: EDTBaseViewController ,feedBackAction: @escaping EDTFeedBackAction ) {
        
        if let feedBack = vc.view.viewWithTag(201) as? UITextView ,let placeholder = vc.view.viewWithTag(202) ,let phone = vc.view.viewWithTag(203) as? UITextField{
            
            var completeItem: UIButton!
            
            if let complete = vc.navigationItem.rightBarButtonItem?.customView as? UIButton  {
                
                completeItem = complete
            }
            if let complete = vc.view.viewWithTag(204) as? UIButton {
                
                completeItem = complete
            }
            
            if let completeItem = completeItem {
                
                let inputs = EDTFeedBackViewModel.WLInput(feedBack: feedBack.rx.text.orEmpty.asDriver(),
                                                          phone: phone.rx.text.orEmpty.asDriver(),
                                                          completTaps: completeItem.rx.tap.asSignal())
                
                viewModel = EDTFeedBackViewModel(inputs)
                
                viewModel
                    .output
                    .completeEnabled
                    .drive(completeItem.rx.isEnabled)
                    .disposed(by: disposed)
                
                viewModel
                    .output
                    .completing
                    .drive(onNext: { (_) in
                        
                        EDTHud.show(withStatus: "意见建议提交中...")
                        
                        vc.view.endEditing(true)
                    })
                    .disposed(by: disposed)
                
                viewModel
                    .output
                    .completed
                    .drive(onNext: { (result) in
                        
                        EDTHud.pop()
                        
                        switch result {
                        case let .ok(msg):
                            
                            EDTHud.showInfo(msg)
                            
                            feedBackAction()
                            
                        case let .failed(msg):
                            
                            EDTHud.showInfo(msg)
                        default: break
                            
                        }
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
    
}
