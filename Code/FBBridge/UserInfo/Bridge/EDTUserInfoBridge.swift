//
//  EDTUserInfoBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import EDTTable
import EDTHud
import EDTBean
import RxCocoa
import EDTCache
import RxSwift
import RxDataSources
import EDTCocoa
import EDTRReq
import EDTUpload

public typealias EDTUserInfoAction = () -> ()

@objc (EDTUserInfoBridge)
public final class EDTUserInfoBridge: EDTBaseBridge {
    
    typealias Section = EDTSectionModel<(), EDTUserInfoBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: EDTUserInfoViewModel!
    
    weak var vc: EDTTableNoLoadingViewController!
}

extension EDTUserInfoBridge {
    
    @objc public func createUserInfo(_ vc: EDTTableNoLoadingViewController ,hasSpace: Bool) {
        
        self.vc = vc
        
        let input = EDTUserInfoViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(EDTUserInfoBean.self),
                                                 itemSelect: vc.tableView.rx.itemSelected,
                                                 hasSpace: hasSpace)
        
        viewModel = EDTUserInfoViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
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
            .zip
            .subscribe(onNext: { (type,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                vc.tableViewSelectData(type, for: ip)
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    @objc public func updateUserInfo(_ type: EDTUserInfoType,value: String ) {
        
        let values =  viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == type}) {
            
            self.vc.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .fade)
        }
    }
    
    @objc public func updateUserInfo(type: EDTUserInfoType,value: String,action: @escaping EDTUserInfoAction) {
        
        EDTHud.show(withStatus: "修改\(type.title)中...")
        
        EDTUserInfoViewModel
            .updateUserInfo(type: type, value: value)
            .drive(onNext: { (result) in
                
                EDTHud.pop()
                switch result {
                    
                case .ok(_):
                    
                    action()
                    
                    EDTHud.showInfo(type == .header ? "上传头像成功" : "修改\(type.title)成功")
                    
                case .failed(let msg): EDTHud.showInfo(msg)
                default: break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func updateHeader(_ data: Data ,action: @escaping EDTUserInfoAction) {
        
        EDTHud.show(withStatus: "上传头像中...")
        
        EDTUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        EDTUploadImgResp(data, file: "headerImg", param: obj as! EDTALCredentialsBean)
                            .subscribe(onNext: { [weak self] (value) in
                                
                                guard let `self` = self else { return }
                                
                                DispatchQueue.main.async {
                                    
                                    self.updateUserInfo(type: EDTUserInfoType.header, value: value, action: action)
                                }
                                
                                }, onError: { (error) in
                                    
                                    EDTHud.pop()
                                    
                                    EDTHud.showInfo("上传头像失败")
                            })
                            .disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    EDTHud.pop()
                    
                    EDTHud.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
}
extension EDTUserInfoBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
