//
//  RepoItemVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 27.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

class RepoItemVC: ItemInfoVc{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems(){
        itemInfoViewOne.set(itemInfoType: .gists, withCount: mUser?.publicGists ?? 0)
        itemInfoViewTwo.set(itemInfoType: .repos, withCount: mUser?.publicRepos ?? 0)
        actionButton.set(backgroundColor: .systemRed, title: "Github Profile")
    }
}
