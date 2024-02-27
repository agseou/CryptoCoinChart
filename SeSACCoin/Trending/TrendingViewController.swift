//
//  TrendingViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class TrendingViewController: BaseViewController {

    let tableView = UITableView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    static func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 1.5
        layout.itemSize = CGSize(width: width, height: width * 0.7)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .zero
        return layout
    }

}
