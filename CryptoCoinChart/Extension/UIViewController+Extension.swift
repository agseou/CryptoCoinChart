//
//  UIViewController+Extension.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import UIKit

extension UIViewController {
    
    // 키보드 숨기기
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
