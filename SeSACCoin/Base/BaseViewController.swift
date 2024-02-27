//
//  BaseViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        setConstraints()
    }
    
    func configureHierarchy() { }
    func configureView() {
        view.backgroundColor = .background
    }
    func setConstraints() { }

    

}
