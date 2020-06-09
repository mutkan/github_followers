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
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
