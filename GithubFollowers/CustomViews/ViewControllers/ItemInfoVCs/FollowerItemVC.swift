//
//  FollowerItemVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 27.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

class FollowerItemVC : ItemInfoVc{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: mUser?.followers ?? 0)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: mUser?.following ?? 0)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: mUser)
    }
}
