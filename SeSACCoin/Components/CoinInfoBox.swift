//
//  CoinInfoView.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import SnapKit

class CoinInfoBox: UIView {
    
    let coinImage = UIImageView()
    private let stackView = UIStackView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(coinImage)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(symbolLabel)
    }
    
    func configureView() {
        coinImage.image = UIImage(resource: .btnStarFill)
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        
        nameLabel.text = "Coin Name"
        nameLabel.textColor = .mainLabel
        nameLabel.font = .boldSystemFont(ofSize: 17)
        
        symbolLabel.text = "Symbol Of Coin"
        symbolLabel.textColor = .subLabel
        symbolLabel.font = .systemFont(ofSize: 15)
    }
    
    func setConstraints() {
        coinImage.snp.makeConstraints {
            $0.left.centerY.equalTo(self)
            $0.size.equalTo(30)
        }
        stackView.snp.makeConstraints {
            $0.left.equalTo(coinImage.snp.right).offset(15)
            $0.centerY.right.equalTo(self)
            $0.verticalEdges.equalTo(self)
        }
    }
}
