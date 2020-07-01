//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 8.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for userName: String)
}

class FollowerListVC: UIViewController{
    var userName: String = ""
    var page = 1
    var hasMoreFollowers = true
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var isSearching = false
    
    enum Section{
        case main
    }
    
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        getFollowers(userName: userName, page: page)
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func getFollowers(userName: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page){ [weak self] result in
            guard let self = self else{
                return
            }
            
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    let message = "This user does not have followers"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                self.updateData(on: followers)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue , buttonTitle: "Ok")
            }
        }
    }
    
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as? FollowerCell
            cell?.setUser(follower: follower)
            return cell
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        print("offset: \(offsetY)")
        print("contentheight: \(contentHeight)")
        print("height: \(height)")
        
        if offsetY > contentHeight - height{
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName: userName, page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.userName = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, filter.isEmpty == false else {
            return
        }
        isSearching = true
        filteredFollowers = followers.filter{
            $0.login.lowercased().contains(filter.lowercased())
        }
        
        updateData(on: filteredFollowers)
    }
}

extension FollowerListVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC: FollowerListVCDelegate{
    func didRequestFollowers(for userName: String) {
        // Get follower for that user
    }
}
