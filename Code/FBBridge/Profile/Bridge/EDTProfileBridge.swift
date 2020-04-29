//
//  EDTProfileBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTTable
import RxDataSources
import EDTCocoa
import EDTCache
import RxCocoa
import RxSwift
import EDTBean
import RxGesture

@objc(EDTProfileActionType)
public enum EDTProfileActionType: Int ,Codable {
    
    case header
    
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
    
    case unLogin
    
    case feedBack
    
    case favor
}

public typealias EDTProfileAction = (_ action: EDTProfileActionType ) -> ()

private var key: Void?

extension EDTTableHeaderView {
    
    @objc public var user: EDTUserBean? {
        get {
            return objc_getAssociatedObject(self, &key) as? EDTUserBean
        }
        set{
            objc_setAssociatedObject(self, &key,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Reactive where Base: EDTTableHeaderView {
    
    var user: Binder<EDTUserBean?> {
        
        return Binder(base) { view, user in
            
            view.user = user
        }
    }
}

@objc (EDTProfileBridge)
public final class EDTProfileBridge: EDTBaseBridge {
    
    typealias Section = EDTSectionModel<(), EDTProfileBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: EDTProfileViewModel!
    
    weak var vc: EDTTableNoLoadingViewController!
}

extension EDTProfileBridge {
    
    @objc public func createProfile(_ vc: EDTTableNoLoadingViewController,hasSpace: Bool,profileAction:@escaping EDTProfileAction) {
        
        let input = EDTProfileViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(EDTProfileBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              hasSpace: hasSpace)
        
        viewModel = EDTProfileViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)  })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .userInfo
            .bind(to: vc.headerView.rx.user)
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: {(type,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                let isLogin = EDTAccountCache.default.isLogin()
                
                switch type.type {
                case .setting: profileAction(.setting)
                    
                case .privacy: profileAction(.privacy)
                case .about: profileAction(.about)
                    
                case .userInfo: profileAction(isLogin ? .userInfo : .unLogin)
                case .address: profileAction(isLogin ? .address : .unLogin)
                case .order: profileAction(isLogin ? .order : .unLogin)
                case .focus: profileAction(isLogin ? .focus : .unLogin)
                case .characters: profileAction(isLogin ? .characters : .unLogin)
                case .myCircle: profileAction(isLogin ? .myCircle : .unLogin)
                case .feedBack: profileAction(.feedBack)
                case .favor: profileAction(isLogin ? .favor : .unLogin)
                case .contactUS:
                    
                    vc.tableViewSelectData(type, for: ip)
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        vc
            .headerView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { (_) in
                
                let isLogin = EDTAccountCache.default.isLogin()
                
                profileAction(isLogin ? .header : .unLogin)
            
            })
            .disposed(by: disposed)
    }
}

extension EDTProfileBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
