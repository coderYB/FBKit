//
//  EDTAboutViewModel.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTViewModel
import RxCocoa
import RxSwift
import WLToolsKit

@objc public final class EDTAboutBean: NSObject {
    
    @objc public var type: EDTAboutType = .space
    
    @objc public var title: String = ""
    
    @objc public var subTitle: String = ""
    
    @objc public static func createAbout(_ type: EDTAboutType ,title: String ,subTitle: String) -> EDTAboutBean {
        
        let about = EDTAboutBean()
        
        about.type = type
        
        about.title = title
        
        about.subTitle = subTitle
        
        return about
    }
    private override init() { }
}

@objc (EDTAboutType)
public enum EDTAboutType: Int {
    
    case version
    
    case email
    
    case wechat
    
    case space
    
    case check
}

extension EDTAboutType {
    
    static var types: [EDTAboutType] {
        
        return [.version,.email,.wechat,.check]
    }
    
    static var spaceTypes: [EDTAboutType] {
        
        return [.space,.email,.wechat]
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        default: return 55
            
        }
    }
    
    var title: String {
        
        switch self {
            
        case .version: return "版本号"
            
        case .email: return "官方邮箱"
            
        case .wechat: return "官方公众号"
            
        case .check: return "检查更新"
            
        case .space: return ""
        }
    }
    
    var subtitle: String {
        
        switch self {
            
        case .version: return "当前版本: \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
            
        case .email:
            
            guard let info = Bundle.main.infoDictionary else { return "" }
            
            return (info["CFBundleDisplayName"] as? String ?? "").transformToPinYin() + "@gmail.com"
            
        case .wechat:
            
            guard let info = Bundle.main.infoDictionary else { return "" }

            return info["CFBundleDisplayName"] as? String ?? ""
            
        case .check: return ""
        case .space: return ""
        }
    }
}

struct EDTAboutViewModel: EDTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<EDTAboutType>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasSpace: Bool
    }
    struct WLOutput {
        
        let zip: Observable<(EDTAboutType,IndexPath)>
        
        let tableData: BehaviorRelay<[EDTAboutType]> = BehaviorRelay<[EDTAboutType]>(value: [])
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip)
        
        self.output.tableData.accept(input.hasSpace ? EDTAboutType.spaceTypes : EDTAboutType.types)
    }
}
