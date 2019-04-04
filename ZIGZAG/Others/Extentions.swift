//
//  Extentions.swift
//  Shop-List-Filter
//
//  Created by Peter Jang on 03/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import UIKit

extension UITextField {
    func givePadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
}


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}


extension StringProtocol where Index == String.Index {
    func nsRange(of range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    //키보드가 TextField를 가리는 것을 방지하기 위해 Contraint 조정
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard keyboardHeight == nil else { return }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight!
            })
            
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight! - distanceToBottom
            if collapseSpace < 0 { return }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset!.x, y: collapseSpace + 10)
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintContentHeight.constant -= self.keyboardHeight!
            self.scrollView.contentOffset = self.lastOffset!
        }
        keyboardHeight = nil
    }
}


extension FunctionViewController {
    
    //키보드가 TextField를 가리는 것을 방지하기 위해 Contraint 조정
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard keyboardHeight == nil else { return }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += self.keyboardHeight!
            })
            
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight! - distanceToBottom
            if collapseSpace < 0 { return }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset!.x, y: collapseSpace + 10)
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintContentHeight.constant -= self.keyboardHeight!
            self.scrollView.contentOffset = self.lastOffset!
        }
        keyboardHeight = nil
    }
}
