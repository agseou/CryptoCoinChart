//
//  FavoriteViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class FavoriteViewController: BaseViewController {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }

    override func configureView() {
        super.configureView()
        
        navigationItem.title = "Favorite Coin"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCollectoinViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectoinViewCell")
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    static func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 2.2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        return layout
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectoinViewCell", for: indexPath) as! FavoriteCollectoinViewCell
        
        return cell
    }
    
    
}
