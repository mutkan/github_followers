//
//  FavoriteCell.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 5.07.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell{
    static let reUseID = "FavoriteCell"
    
    let avatarImageView = CustomAvatarImageView(frame: .zero)
    let userNameLabel = CustomTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower){
        avatarImageView.downloadImage(from: favorite.avatarUrl)
        userNameLabel.text = favorite.login
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
}
