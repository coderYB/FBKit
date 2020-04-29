//
//  UITextField+WL.swift
//  TSTFKit_Swift
//
//  Created by three stone 王 on 2018/11/17.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @objc (EDT_backgroundColor:)
    public func EDT_backgroundColor(_ color: UIColor) {
        
        backgroundColor = color
    }
    @objc (EDT_font:)
    public func EDT_font(_ font: UIFont) {
        
        self.font = font
    }
    @objc (EDT_textColor:)
    public func EDT_textColor(_ color: UIColor) {
        
        textColor = color
    }
    @objc (EDT_textAlignment:)
    public func EDT_textAlignment(_ alignment: NSTextAlignment) {
        
        textAlignment = alignment
    }
    @objc (EDT_keyboardType:)
    public func EDT_keyboardType(_ keyboardType: UIKeyboardType) {
        
        self.keyboardType = keyboardType
    }
    @objc (EDT_clearButtonMode:)
    public func EDT_clearButtonMode(_ clearButtonMode: UITextField.ViewMode) {
        
        self.clearButtonMode = clearButtonMode
        
    }
    @objc (EDT_returnKeyType:)
    public func EDT_returnKeyType(_ returnKeyType: UIReturnKeyType) {
        
        self.returnKeyType = returnKeyType
    }
    @objc (EDT_rightViewMode:)
    public func EDT_rightViewMode(_ rightViewMode: UITextField.ViewMode) {
        
        self.rightViewMode = rightViewMode
    }
    @objc (EDT_leftViewMode:)
    public func EDT_leftViewMode(_ leftViewMode: UITextField.ViewMode) {
        
        self.leftViewMode = leftViewMode
    }
    @objc (EDT_leftView:)
    public func EDT_leftView(_ leftView: UIView) {
        
        self.leftView = leftView
    }
    @objc (EDT_rightView:)
    public func EDT_rightView(_ rightView: UIView) {
        
        self.rightView = rightView
    }
}

public typealias EDTShouldReturn = () -> Bool

public typealias EDTShouldClear = () -> Bool

extension UITextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    fileprivate var shouldReturn: EDTShouldReturn! {
        set {
            
            objc_setAssociatedObject(self, "shouldReturn", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldReturn") as? EDTShouldReturn
        }
    }
    @objc (EDT_shouldReturn:)
    public func EDT_shouldReturn(_ shouldReturn: @escaping () -> Bool) {
        
        self.shouldReturn = shouldReturn
    }
    @objc (textFieldShouldReturn:)
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if shouldReturn == nil {
            
            return true
        }
        
        return shouldReturn!()
    }
    
    fileprivate var shouldClear: EDTShouldClear! {
        
        set {
            
            objc_setAssociatedObject(self, "shouldClear", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldClear") as? EDTShouldClear
        }
    }
    @objc (EDT_shouldClear:)
    public func EDT_shouldClear(_ shouldClear: @escaping () -> Bool) {
        
        self.shouldClear = shouldClear
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if shouldClear == nil {
            
            return true
        }
        
        return shouldClear!()
    }
}

