//
//  FavoritesListViewController.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 1.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
    
    let uiTableView = UITableView()
    let favorites: [Follower] = []
    
    func configureViewController(){
        title = "Favorites"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureViewController()
        
        getFavorites()
    }
    
    func getFavorites(){
        PersistenceManager.retrieveFavorites { result in
            switch result{
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                break
            }
        }
    }
}
