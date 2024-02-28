//
//  TrendingViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class TrendingViewController: BaseViewController {
    
    private var dataSource = TempMock.dataSource
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
        switch self.dataSource[section] {
        case .favorite:
            return TrendingViewController.setMyFavoriteCollectionViewLayout()
        case .topRank:
            return TrendingViewController.setTopRankCollectionViewLayout()
        }
      }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "Crypto Coin"
        
        collectionView.dataSource = self
        collectionView.register(MyFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "MyFavoriteCollectionViewCell")
        collectionView.register(TopRankCollectionViewCell.self, forCellWithReuseIdentifier: "TopRankCollectionViewCell")
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    static func setMyFavoriteCollectionViewLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        //section.boundarySupplementaryItems = [header, footer]
        return section
    }
    
    static func setTopRankCollectionViewLayout() -> NSCollectionLayoutSection {
        // item
          let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
          )
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
          let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1.0/4.0)
          )
          
          // group
          let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 4
          )
          
          // section
          let section = NSCollectionLayoutSection(group: group)
          section.orthogonalScrollingBehavior = .continuous
          return section
    }
    
}

extension TrendingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource[section] {
        case let .favorite(items):
            return items.count
        case let .topRank(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.dataSource[indexPath.section] {
        case let .favorite(items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFavoriteCollectionViewCell", for: indexPath) as! MyFavoriteCollectionViewCell
            
            return cell
        case let .topRank(items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRankCollectionViewCell", for: indexPath) as! TopRankCollectionViewCell
            
            return cell
        }
    }
    
}
