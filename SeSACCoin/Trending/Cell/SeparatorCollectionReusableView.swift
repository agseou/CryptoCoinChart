//
//  SeparatorCollectionReusableView.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import UIKit

class SeparatorCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .subBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
