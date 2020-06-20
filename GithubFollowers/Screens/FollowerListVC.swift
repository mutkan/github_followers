//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 8.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController{
    var userName: String = ""
    var page = 1
    var hasMoreFollowers = true
    
    var followers: [Follower] = []
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
        getFollowers(userName: userName, page: page)
    }
    
    func getFollowers(userName: String, page: Int){
        NetworkManager.shared.getFollowers(for: userName, page: page){ [weak self] result in
            guard let self = self else{
                return
            }
            switch result {
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                self.updateData()
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue , buttonTitle: "Ok")
            }
        }
    }
    
    func updateData(){
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
}
