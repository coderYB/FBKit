//
//  EDTCarouselBridge.swift
//  EDTBridge
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import EDTCollection
import RxCocoa
import RxSwift
import RxDataSources
import EDTCocoa
import WLToolsKit
import ObjectMapper

public typealias EDTCarouselAction = (_ carouse: EDTCarouselBean) -> ()

@objc (EDTCarouselBridge)
public final class EDTCarouselBridge: EDTBaseBridge {
    
    var viewModel: EDTCarouselViewModel!
    
    typealias Section = EDTSectionModel<(), EDTCarouselBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: EDTCollectionNoLoadingViewController!
    
    var style: EDTCarouselStyle = .normal
}

// MARK: skip item 101 pagecontrol 102
extension EDTCarouselBridge {
    
    @objc public func createCarousel(_ vc: EDTCollectionNoLoadingViewController ,canPageHidden: Bool ,canTimerResp: Bool,carousels: [[String: String]],style: EDTCarouselStyle ,carouseAction: @escaping EDTCarouselAction) {
        
        if let pageControl = vc.view.viewWithTag(102) as? UIPageControl {
            
            pageControl.numberOfPages = carousels.count
            
            self.vc = vc
            
            self.style = style
            
            let input = EDTCarouselViewModel.WLInput(contentoffSetX: vc.collectionView.rx.contentOffset.map({ $0.x }),
                                                     modelSelect: vc.collectionView.rx.modelSelected(EDTCarouselBean.self),
                                                     itemSelect: vc.collectionView.rx.itemSelected,
                                                     canTimerResp: canTimerResp,
                                                     currentPage: BehaviorRelay<Int>(value: 0),
                                                     style: style)
            
            viewModel = EDTCarouselViewModel(input, disposed: disposed)
            
            var result : [EDTCarouselBean] = []
            
            for carousel in carousels {
                
                let c = EDTCarouselBean(JSON: carousel)!
                
                result += [c]
                
            }
            
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
                configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip)})
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .tableData
                .asObservable()
                .map({ [Section(model: (), items: $0)] })
                .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
            
            viewModel
                .output
                .zip
                .subscribe(onNext: { (carouse,ip) in
                    
                    carouseAction(carouse)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .timered
                .subscribe(onNext: { [unowned self] (index) in
                    
                    if !self.viewModel.output.tableData.value.isEmpty {
                        
                        vc.collectionView.selectItem(at: IndexPath(item: index, section:0), animated: true, scrollPosition: .centeredHorizontally)
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .currentPage
                .bind(to: pageControl.rx.currentPage)
                .disposed(by: disposed)
            
            var mutable: [EDTCarouselBean] = []
            
            for _ in 0..<999 {
                
                mutable += result
            }
            
            viewModel
                .output
                .tableData
                .accept(mutable)
            
            vc
                .collectionView
                .rx
                .setDelegate(self)
                .disposed(by: disposed)
        }
    }
}
extension EDTCarouselBridge: UICollectionViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        DispatchQueue.main.async {
            
            let width = self.style == .normal ? WL_SCREEN_WIDTH : (WL_SCREEN_WIDTH - 60 )
            
            let floatx = scrollView.contentOffset.x / width
            
            let intx = floor(floatx)
            
            if floatx + 0.5 >= intx {
                
                self.vc.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width) + 1, section:0), animated: true, scrollPosition: .centeredHorizontally)
            } else {
                
                self.vc.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width), section:0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
}
