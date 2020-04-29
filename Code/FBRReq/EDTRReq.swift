//
//  ZRealReq.swift
//  ZRealReq
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import EDTCache
import EDTReq
import EDTUpload
import EDTSign
import EDTError
import EDTObservableReq

public func EDTDictResp<T : EDTObservableReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !EDTAccountCache.default.token.isEmpty {
            
            params.updateValue(EDTAccountCache.default.token, forKey: "token")
        }
        
        EDTReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in
            
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func EDTArrayResp<T : EDTObservableReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !EDTAccountCache.default.token.isEmpty {
            
            params.updateValue(EDTAccountCache.default.token, forKey: "token")
        }
        EDTReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(data as! [Any])

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

// 无返回值的 在data里
public func EDTVoidResp<T : EDTObservableReq>(_ req: T) -> Observable<Void> {
    
    return Observable<Void>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !EDTAccountCache.default.token.isEmpty {
            
            params.updateValue(EDTAccountCache.default.token, forKey: "token")
        }
        
        EDTReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(())

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func EDTAliResp<T : EDTObservableReq>(_ req: T) -> Observable<EDTALCredentialsBean> {
    
    return Observable<EDTALCredentialsBean>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !EDTAccountCache.default.token.isEmpty {
            
            params.updateValue(EDTAccountCache.default.token, forKey: "token")
        }
        EDTUpload.fetchAliObj(withUrl: req.host + req.reqName , andParams: params, andHeader: req.headers, andSucc: { (credentials) in

            observer.onNext(credentials)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 131 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func EDTUploadImgResp(_ data: Data ,file: String ,param: EDTALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        EDTUpload.uploadAvatar(with: data, andFile: file, andUid: EDTAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func EDTUploadPubImgResp(_ data: Data ,file: String ,param: EDTALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        EDTUpload.uploadImage(with: data, andFile: file, andUid: EDTAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}
public func EDTUploadVideoResp(_ data: Data ,file: String ,param: EDTALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        EDTUpload.uploadVideo(with: data, andFile: file, andUid: EDTAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
//
        return Disposables.create { }
    })
}

public func EDTTranslateResp<T : EDTObservableReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        EDTReq.postTranslateWithParams(params: req.params, succ: { (data) in
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        return Disposables.create { }
    })
}

public func EDTAreaResp<T : EDTObservableReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        EDTReq.postAreaWithUrl(url: req.host + req.reqName, params: req.params, succ: { (data) in
            
            if data is NSDictionary {
                
                observer.onError(EDTError.ServerResponseError("没有权限"))
            } else if data is NSArray {
                
                observer.onNext(data as! [Any])
                
                observer.onCompleted()
            }

        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(EDTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(EDTError.HTTPFailed(error)) }
        })
        
        
        return Disposables.create { }
    })
}
