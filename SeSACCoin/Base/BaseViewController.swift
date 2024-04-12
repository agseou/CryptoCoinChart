//
//  BaseViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import SnapKit
import RealmSwift

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
        setupProfileButton()
    }
    func setConstraints() { }
    
    private func setupProfileButton() {
        let profileImage = UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal)
        let profileButton = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(tapProfileButton))
        navigationItem.rightBarButtonItem = profileButton
    }
    
    @objc private func tapProfileButton() {
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex = 3
        }
    }
    
}
