//
//  BaseCollectionViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    func configureView() { }
    func setConstraints() { }
}
