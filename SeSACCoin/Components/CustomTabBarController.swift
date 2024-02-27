//
//  CustomTabBarController.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let TrendNavController = CustomNavigationController(rootViewController: TrendingViewController())
    let SearchNavController = CustomNavigationController(rootViewController: SearchViewController())
    let FavoriteNavController = CustomNavigationController(rootViewController: FavoriteViewController())
    let ProfileNavController = CustomNavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .background
        
        // 탭바 아이템 설정
        // 0
        TrendNavController.tabBarItem = UITabBarItem(title: nil, image: .tabTrendInactive, selectedImage: .tabTrend)
        TrendNavController.tabBarItem.tag = 0
        // 1
        SearchNavController.tabBarItem = UITabBarItem(title: nil, image: .tabSearchInactive, selectedImage: .tabSearch)
        SearchNavController.tabBarItem.tag = 1
        // 2
        FavoriteNavController.tabBarItem = UITabBarItem(title: nil, image: .tabPortfolioInactive, selectedImage: .tabPortfolio)
        FavoriteNavController.tabBarItem.tag = 2
        // 3
        ProfileNavController.tabBarItem = UITabBarItem(title: nil, image: .tabUserInactive, selectedImage: .tabUser)
        ProfileNavController.tabBarItem.tag = 3
        
        self.viewControllers = [TrendNavController, SearchNavController, FavoriteNavController, ProfileNavController]
    }
    

    

}
