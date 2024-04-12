//
//  ProfileTableViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/03/04.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {

    let profileView = UIImageView()
    let nameLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(profileView)
        contentView.addSubview(nameLabel)
    }
    
    override func configureView() {
        profileView.backgroundColor = .accent
        DispatchQueue.main.async {
            self.profileView.layer.cornerRadius = self.profileView.bounds.width/2
        }
        profileView.clipsToBounds = true
        profileView.contentMode = .scaleAspectFill
        profileView.layer.borderColor = UIColor.accent.cgColor
        profileView.layer.borderWidth = 3
        
        nameLabel.text = "User"
        nameLabel.textColor = .mainLabel
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    override func setConstraints() {
        profileView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.verticalEdges.equalTo(contentView).inset(10)
            $0.left.equalTo(contentView).offset(20)
            $0.size.equalTo(100)
        }
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(profileView.snp.right).offset(15)
            $0.centerY.equalTo(contentView)
        }
    }

}
