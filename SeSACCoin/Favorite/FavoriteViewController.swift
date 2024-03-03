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
    private let refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "Favorite Coin"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.register(FavoriteCollectoinViewCell.self, forCellWithReuseIdentifier: "FavoriteCollectoinViewCell")
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshFavoriteList), for: .valueChanged)
    }
    
    @objc private func refreshFavoriteList() {
        viewModel.inputViewDidLoadTrigger.value = ()
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
        return viewModel.favoriteList.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectoinViewCell", for: indexPath) as! FavoriteCollectoinViewCell
        
        let data = viewModel.favoriteList.value[indexPath.item]
        
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
        vc.ids = viewModel.favoriteList.value[indexPath.item].coinID
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FavoriteViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    // 드래그
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print("drag > ", indexPath)
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    // 드랍
    // drag가 활성화될때만 drop!
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard collectionView.hasActiveDrag else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        print("drop>", coordinator.destinationIndexPath)
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        
        guard coordinator.proposal.operation == .move else { return }
        move(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
    }
    
    private func move(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        guard
            let sourceItem = coordinator.items.first,
            let sourceIndexPath = sourceItem.sourceIndexPath
        else { return }
        
        collectionView.performBatchUpdates { 
            self.move(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
        } completion: { finish in
            print("finish:", finish)
            coordinator.drop(sourceItem.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    private func move(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        let sourceItem = viewModel.favoriteList.value[sourceIndexPath.item]
        
        viewModel.favoriteList.value.remove(at: sourceIndexPath.item)
        viewModel.favoriteList.value.insert(sourceItem, at: destinationIndexPath.item)
        
        collectionView.deleteItems(at: [sourceIndexPath])
        collectionView.insertItems(at: [destinationIndexPath])
    }
    
}
