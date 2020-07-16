//
//  CustomTabBarController.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 15.07.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        let searchNC                    = createSearchNavigationController()
        let favoritesNC                 = createFavoritesNavigationController()
        viewControllers = [searchNC, favoritesNC]
    }
    
    func createSearchNavigationController() -> UINavigationController{
        let searchVC        = SearchViewController()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNavigationController() -> UINavigationController{
        let favoritesVC         = FavoritesListViewController()
        favoritesVC.title       = "Favorites"
        favoritesVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
}
