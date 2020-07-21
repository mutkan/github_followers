//
//  CustomItemInfoView.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 26.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class CustomItemInfoView: UIView{
    
    let symbolImageView = UIImageView()
    let titleLabel = CustomTitleLabel(textAlignment: .center, fontSize: 14)
    let countLabel = CustomTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor = .label
        symbolImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            countLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 6),
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbolsImages.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbolsImages.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbolsImages.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbolsImages.following
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
    
}
