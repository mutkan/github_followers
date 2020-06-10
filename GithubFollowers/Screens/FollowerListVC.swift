//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 8.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController{
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        NetworkManager.shared.getFollowers(for: userName!, page: 1){ (followers, errorMessage) in
            guard let followers = followers else {
                self.presentAlertOnMainThread(title: "Error", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Followes count: \(followers.count)")
            print(followers)
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
