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
    var favorites: [Follower] = []
    
    func configureViewController(){
        title = "Favorites"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(uiTableView)
        uiTableView.frame       = view.bounds
        uiTableView.rowHeight   = 80
        uiTableView.delegate    = self
        uiTableView.dataSource  = self
        uiTableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reUseID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    
    func getFavorites(){
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No Favorites? \n\n Add one on the follower screen", in: self.view)
                }else{
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.view.bringSubviewToFront(self.uiTableView)
                        self.uiTableView.reloadData()
                    }
                    
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reUseID, for: indexPath) as? FavoriteCell
        
        let favorite = favorites[indexPath.row]
        cell?.set(favorite: favorite)
        return cell!
    }
}
