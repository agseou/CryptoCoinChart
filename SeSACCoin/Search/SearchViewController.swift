//
//  SearchViewController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit
import Toast
import Kingfisher

class SearchViewController: BaseViewController {
    
    let viewModel = SearchViewModel()
    let repository = RealmRepository()
    
    let searchController = UISearchController()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        self.hideKeyboard()
        
        navigationItem.title = "Search"
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.separatorStyle = .none
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        viewModel.inputSearchKeyword.value = searchBar.text
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        let data = viewModel.searchList.value[indexPath.row]
        
        let searchText = searchController.searchBar.text ?? ""
        
        
        let nameAttributedString = NSMutableAttributedString(string: data.name)
        if !searchText.isEmpty {
            let range = (data.name as NSString).range(of: searchText, options: .caseInsensitive)
            nameAttributedString.addAttribute(.foregroundColor, value: UIColor.accent, range: range)
        }
        
        cell.coininfo.nameLabel.attributedText = nameAttributedString
        cell.coininfo.symbolLabel.text = data.symbol
        cell.coininfo.coinImage.kf.setImage(with: URL(string: data.thumb))
        cell.favoriteBtn.tag = indexPath.row
        cell.favoriteBtn.addTarget(self, action:#selector(tapFavoriteBtn(_:)), for: .touchUpInside)
        cell.favoriteBtn.setImage(UIImage(resource: repository.isFavorite(coinID: data.id) ? .btnStar : .btnStarFill), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.ids = viewModel.searchList.value[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func tapFavoriteBtn(_ sender: UIButton) {
        
        let btnIDX = sender.tag
        let data = viewModel.searchList.value[btnIDX].id
        if repository.isFavorite(coinID: data) {
            if repository.canAddFavorite(){
                view.makeToast("즐겨찾기에 추가 됐습니다.")
                sender.setImage(UIImage(resource: .btnStarFill), for: .normal)
            } else {
                view.makeToast("즐겨찾기는 최대 10개까지 가능합니다")
            }
        } else {
            view.makeToast("즐겨찾기가 해제 됐습니다.")
            sender.setImage(UIImage(resource: .btnStar), for: .normal)
        }
        repository.toggleFavorite(coinID: data)
        
    }
    
}



