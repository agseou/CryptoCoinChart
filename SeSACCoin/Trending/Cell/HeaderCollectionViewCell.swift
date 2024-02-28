//
//  HeaderCollectionViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import UIKit

class HeaderCollectionViewCell: BaseCollectionReusableView {
    
    let headerLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(headerLabel)
    }
    
    override func configureView() {
        headerLabel.text = "Header"
        headerLabel.textColor = .mainLabel
        headerLabel.textAlignment = .left
        headerLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    override func setConstraints() {
        headerLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
        }
    }
    
}
