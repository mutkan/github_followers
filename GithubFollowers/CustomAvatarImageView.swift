//
//  CustomAvatarImageView.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 11.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class CustomAvatarImageView: UIImageView{
    let placeHolder = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        layer.cornerRadius = 10
        image = placeHolder
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
