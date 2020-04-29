//
//  EDTUserCenterViewModel.swift
//  EDTBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
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

@objc public final class EDTUserCenterBean: NSObject {
    
    @objc public var type: EDTUserCenterType = .userInfo
    
    @objc public var title: String = ""
    
    @objc public static func createUserCenter(_ type: EDTUserCenterType ,title: String) -> EDTUserCenterBean {
        
        let profile = EDTUserCenterBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createUserCenterTypes() -> [EDTUserCenterBean] {
        
        var result: [EDTUserCenterBean] = []
        
        for item in EDTUserCenterType.types {
            
            result += [EDTUserCenterBean.createUserCenter(item, title: item.title)]
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (EDTUserCenterType)
public enum EDTUserCenterType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case feedBack
    
    case share
    
    case service
    
    case header
    
    case version
}

extension EDTUserCenterType {
    
    static var types: [EDTUserCenterType] {
        
        if EDTConfigure.fetchPType() == .swimming {
            
            return [userInfo,.privacy,.about,.feedBack,.version,.setting]
        }
        
        return [userInfo,.contactUS,.feedBack,.setting]
    }
    
    var cellHeight: CGFloat {
        
        switch self {
            
        case .header: return 100
            
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
            
        case .address: return "我的地址"
            
        case .order: return "订单管理"
            
        case .characters: return "角色信息"
            
        case .feedBack: return "意见建议"
            
        case .share: return "分享"
            
        case .service: return "服务热线"
            
        case .version: return "当前版本"
        default: return ""
            
        }
    }
}

struct EDTUserCenterViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTUserCenterBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(EDTUserCenterBean,IndexPath)>
        
        let tableData: BehaviorRelay<[EDTUserCenterBean]> = BehaviorRelay<[EDTUserCenterBean]>(value: [])
        
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
        
        self.output.tableData.accept(EDTUserCenterBean.createUserCenterTypes())
    }
}

