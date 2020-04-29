//
//  EDTVideoBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/22.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTTransition
import EDTHud
import EDTCache

@objc(EDTVideoActionType)
public enum EDTVideoActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10
}

public typealias EDTVideoAction = (_ action: EDTVideoActionType) -> ()

@objc (EDTVideoBridge)
public final class EDTVideoBridge: EDTBaseBridge {
    
    var viewModel: EDTVideoViewModel!
    
    weak var vc: EDTTViewController!
}
extension EDTVideoBridge {
    
    @objc public func createVideo(_ vc: EDTTViewController) {
        
        self.vc = vc
    }
}
extension EDTVideoBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,action: @escaping EDTVideoAction) {
        
        if !EDTAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        EDTHud.show(withStatus: "添加黑名单中...")
        
        EDTVideoViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    EDTHud.showInfo(msg)
                    
                    action(.black)
                    
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,action: @escaping EDTVideoAction) {
        
        if !EDTAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        EDTHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        EDTVideoViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok:
                    
                    action(.focus)
                    
                    EDTHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }

    @objc public func like(_ encoded: String,isLike: Bool,action: @escaping EDTVideoAction) {
        
        if !EDTAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        EDTHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        EDTVideoViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: {(result) in
                
                EDTHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    action(.like)
                    
                    EDTHud.showInfo(msg)
                case .failed(let msg):
                    
                    EDTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}
