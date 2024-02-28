//
//  FavoriteCollectoinViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import UIKit

class FavoriteCollectoinViewCell: BaseCollectionViewCell {

    let box = UIView()
    let coinInfo = CoinInfoBox()
    let stackView = UIStackView()
    let current_price = UILabel()
    let price_change_percentage = UILabel()
    
    
    override func configureHierarchy() {
        contentView.addSubview(box)
        box.addSubview(coinInfo)
        box.addSubview(stackView)
        stackView.addArrangedSubview(current_price)
        stackView.addArrangedSubview(price_change_percentage)
    }
    
    override func configureView() {
        box.layer.shadowColor = UIColor.subLabel.cgColor
        box.layer.shadowOffset = .zero
        box.layer.shadowOpacity = 0.5
        //box.layer.shadowRadius = 3
        box.backgroundColor = .background
        DispatchQueue.main.async {
            self.box.layer.cornerRadius = 15
        }
        
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        
        current_price.textColor = .mainLabel
        current_price.text = "100000000"
        
        price_change_percentage.textColor = .mainLabel
        price_change_percentage.text = "+12.13"
        price_change_percentage.backgroundColor = .subRed
        price_change_percentage.layer.cornerRadius = 5
    }
    
    override func setConstraints() {
        box.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        coinInfo.snp.makeConstraints {
            $0.left.top.equalTo(box).offset(10) 
            $0.right.equalTo(box).inset(10)
        }
        stackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(coinInfo.snp.bottom).offset(30)
            $0.right.bottom.equalTo(box).inset(10)
            $0.left.equalTo(box).offset(10)
        }

    }

}
