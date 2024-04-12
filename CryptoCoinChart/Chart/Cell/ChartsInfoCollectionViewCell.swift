//
//  ChartsInfoCollectionViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/29.
//

import UIKit

class ChartsInfoCollectionViewCell: BaseCollectionViewCell {
    
    let Vstack = UIStackView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(Vstack)
        Vstack.addArrangedSubview(titleLabel)
        Vstack.addArrangedSubview(descriptionLabel)
    }
    
    override func configureView() {
        Vstack.axis = .vertical
        Vstack.distribution = .fillEqually
        Vstack.alignment = .leading
        Vstack.spacing = 2
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
    }
    
    override func setConstraints() {
        Vstack.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
}
