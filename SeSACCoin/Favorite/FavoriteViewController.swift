//
//  FavoriteViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import Kingfisher

class FavoriteViewController: BaseViewController {

    let viewModel = FavoriteViewModel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    var list: [Favorite]  = []
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.outputList.bind { data in
            self.list = data
            self.collectionView.reloadData()
        }
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
        let width = (UIScreen.main.bounds.width - 20)/2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 5, left: 10, bottom: 5, right: 10)
        return layout
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectoinViewCell", for: indexPath) as! FavoriteCollectoinViewCell
        
        let data = list[indexPath.item]
        
        cell.coinInfo.nameLabel.text = data.name
        cell.coinInfo.symbolLabel.text = data.symbol
        cell.coinInfo.coinImage.kf.setImage(with: URL(string: data.image))
        cell.current_price.text = data.current_price.description
        cell.price_change_percentage.text = data.price_change_percentage.description
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.navigationItem.backButtonTitle = nil
        vc.ids = list[indexPath.item].coinID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
