//
//  TrendingViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import RealmSwift
import Kingfisher

enum TrendingSection {
    case favorites([Favorite])
    case coinTopRank([Item])
    case nftTopRank([Nft])
    
    var header: String {
        switch self {
        case .favorites(_):
            return "My Favorite"
        case .coinTopRank(_):
            return "Top15 Coin"
        case .nftTopRank(_):
            return "Top7 NFT"
        }
    }
}


class TrendingViewController: BaseViewController {
    
    let viewModel = TrendingViewModel()
    private var dataSource: [TrendingSection] = []
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
        switch self.dataSource[section] {
        case .favorites:
            return TrendingViewController.setMyFavoriteCollectionViewLayout()
        case .coinTopRank, .nftTopRank:
            return TrendingViewController.setTopRankCollectionViewLayout()
        }
    }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.outputsections.bind { data in
            self.dataSource = data
            self.collectionView.reloadData()
        }
        print(dataSource)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "Crypto Coin"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "MyFavoriteCollectionViewCell")
        collectionView.register(MoreCollectionViewCell.self, forCellWithReuseIdentifier: "MoreCollectionViewCell")
        collectionView.register(TopRankCollectionViewCell.self, forCellWithReuseIdentifier: "TopRankCollectionViewCell")
        collectionView.register(HeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell")
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //즐겨찾기 section Layout
    static func setMyFavoriteCollectionViewLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.6),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        // header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 5)
        return section
        
        
    }
    
    // Top 랭킹 section 레이아웃
    static func setTopRankCollectionViewLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .fractionalHeight(1.0/3.0)
        )
        
        // group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )
        
        // header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 5)
        section.interGroupSpacing = 30
        return section
    }
    
}


// MARK: - UICollectionViewDataSourcce
extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .favorites(let items):
            return min(items.count, 3) + (items.count > 3 ? 1 : 0)
        case .coinTopRank(let items):
            return items.count
        case .nftTopRank(let items):
            return items.count
        }
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.dataSource[indexPath.section] {
        case .favorites(let items):
            if indexPath.item == 3 && items.count > 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionViewCell", for: indexPath) as! MoreCollectionViewCell
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFavoriteCollectionViewCell", for: indexPath) as! MyFavoriteCollectionViewCell
                
                let data = items[indexPath.item]
                
                cell.coinInfo.coinImage.kf.setImage(with: URL(string: data.image))
                cell.coinInfo.nameLabel.text = data.name
                cell.coinInfo.symbolLabel.text = data.symbol
                cell.price.text = data.current_price.formattedWon()
                cell.price_change_percentage.text = data.price_change_percentage.formattedPercent()
                cell.price_change_percentage.textColor = data.price_change_percentage.isPositive() ? .redLabel : .blueLabel
                
                return cell
            }
        case .coinTopRank(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRankCollectionViewCell", for: indexPath) as! TopRankCollectionViewCell
            
            let data = items[indexPath.item]
            
            cell.rank.text = String(indexPath.item + 1)
            cell.coinInfo.coinImage.kf.setImage(with: URL(string: data.small))
            cell.coinInfo.nameLabel.text = data.name
            cell.coinInfo.symbolLabel.text = data.symbol
            cell.price.text = data.data.price
            cell.price_change_percentage.text = data.data.price_change_percentage_24h.krw.formattedPercent()
            cell.price_change_percentage.textColor = data.data.price_change_percentage_24h.krw.isPositive() ? .redLabel : .blueLabel
            
            return cell
            
        case .nftTopRank(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRankCollectionViewCell", for: indexPath) as! TopRankCollectionViewCell
            
            let data = items[indexPath.item]
            
            cell.rank.text = String(indexPath.item + 1)
            cell.coinInfo.coinImage.kf.setImage(with: URL(string: data.thumb))
            cell.coinInfo.nameLabel.text = data.name
            cell.coinInfo.symbolLabel.text = data.symbol
            cell.price.text = data.data.floor_price
            cell.price_change_percentage.text = data.floor_price_24h_percentage_change.formattedPercent()
            cell.price_change_percentage.textColor = data.floor_price_24h_percentage_change.isPositive() ? .redLabel : .blueLabel
            
            return cell
        }
    }
    
    // viewForSupplementaryElementOfKind -> Header, Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
            
            header.headerLabel.text = self.dataSource[indexPath.section].header
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataSource[indexPath.section] {
        case .favorites(let items):
            if indexPath.item == 3 && items.count > 3 {
                tabBarController?.selectedIndex = 2
            } else {
                let vc = ChartViewController()
                vc.ids = items[indexPath.item].coinID
                navigationController?.pushViewController(vc, animated: true)
            }
        case .coinTopRank(let items):
            let vc = ChartViewController()
            vc.ids = items[indexPath.item].id
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
