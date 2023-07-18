//
//  KeyboardReactiveViewController.swift
//
//
//  Created by Oleksii Perov on 7/19/23.
//

import Foundation
import UIKit

open class KeyboardReactiveViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardNotifications()
    }
    
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    open func keyboardWillShow(withSize size: CGRect, duration: CGFloat) {}
    
    open func keyboardWillHide(withDuration duration: CGFloat) {}
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = userInfo[
                UIResponder.keyboardAnimationDurationUserInfoKey
              ] as? Double else {
            return
        }
        keyboardWillShow(withSize: keyboardSize, duration: duration)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[
                UIResponder.keyboardAnimationDurationUserInfoKey
              ] as? Double else {
            return
        }
        keyboardWillHide(withDuration: duration)
    }
}
