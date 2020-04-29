//
//  EDTProfileViewModel.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import EDTBean
import EDTSign
import EDTApi
import EDTRReq
import EDTCache
import EDTObservableMapper

@objc public final class EDTProfileBean: NSObject {
    
    @objc public var type: EDTProfileType = .space
    
    @objc public var title: String = ""
    
    @objc public static func createProfile(_ type: EDTProfileType ,title: String) -> EDTProfileBean {
        
        let profile = EDTProfileBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createProfileTypes(_ hasSpace: Bool) -> [EDTProfileBean] {
        
        var result: [EDTProfileBean] = []
        
        if hasSpace {
            
            for item in EDTProfileType.spaceTypes {
                
                result += [EDTProfileBean.createProfile(item, title: item.title)]
            }
            
        } else {
            
            for item in EDTProfileType.types {
                
                result += [EDTProfileBean.createProfile(item, title: item.title)]
            }
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (EDTProfileType)
public enum EDTProfileType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case feedBack
    
    case favor
}

extension EDTProfileType {
    
    static var spaceTypes: [EDTProfileType] {
        
        if EDTConfigure.fetchPType() == .swimming {
            
            return [.space,userInfo,.order,.address,.favor,.space,.contactUS,.privacy,.about,.space,.feedBack,.setting]
        }
        
        return [.space,userInfo,.space,.contactUS,.privacy,.about,.space,.feedBack,.setting]
        
    }
    
    static var types: [EDTProfileType] {
        
        if EDTConfigure.fetchPType() == .swimming {
            
            return [userInfo,.order,.address,.favor,.contactUS,.privacy,.about,.feedBack,.setting]
        }
        
        return [userInfo,.contactUS,.privacy,.about,.feedBack,.setting]
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
        default: return 55
        }
    }
    
    var title: String {
        
        switch self {
            
        case .about: return "关于我们"
            
        case .contactUS: return "联系我们"
            
        case .userInfo: return "用户资料"
            
        case .setting: return "设置"
            
        case .privacy: return "隐私政策"
            
        case .focus: return "我的关注"
            
        case .myCircle: return "我的发布"
            
        case .address: return "地址管理"
            
        case .order: return "订单管理"
            
        case .characters: return "角色信息"
            
        case .feedBack: return "意见建议"
            
        case .favor: return "我的收藏"
            
        default: return ""
            
        }
    }
}

struct EDTProfileViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTProfileBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasSpace: Bool
    }
    
    struct WLOutput {
        
        let zip: Observable<(EDTProfileBean,IndexPath)>
        
        let tableData: BehaviorRelay<[EDTProfileBean]> = BehaviorRelay<[EDTProfileBean]>(value: [])
        
        let userInfo: Observable<EDTUserBean?>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let userInfo: Observable<EDTUserBean?> = EDTUserInfoCache.default.rx.observe(EDTUserBean.self, "userBean")
        
        EDTUserInfoCache.default.userBean = EDTUserInfoCache.default.queryUser()
        
        EDTDictResp(EDTApi.fetchProfile)
            .mapObject(type: EDTUserBean.self)
            .map({ EDTUserInfoCache.default.saveUser(data: $0) })
            .subscribe(onNext: { (_) in })
            .disposed(by: disposed)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip, userInfo: userInfo)
        
        self.output.tableData.accept(EDTProfileBean.createProfileTypes(input.hasSpace))
    }
}

