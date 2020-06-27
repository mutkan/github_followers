//
//  UserInfoHeaderVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 23.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class UserInfoHeaderVC: UIViewController{
    var mUser: User? = nil
    
    let avatarImageView = CustomAvatarImageView(frame: .zero)
    let userNameLabel = CustomTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = CustomSecondTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = CustomSecondTitleLabel(fontSize: 18)
    let bioLabel = CustomBodyLabel(textAlignment: .left)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        layoutUI()
        configureUI()
    }
    
    func addSubViews() {
        view.addSubview(avatarImageView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureUI(){
        avatarImageView.downloadImage(from: mUser?.avatarUrl ?? "")
        userNameLabel.text = mUser?.login
        nameLabel.text = mUser?.name
        locationLabel.text = mUser?.location ?? "No Location Available"
        bioLabel.text = mUser?.bio ?? "No Bio Available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        mUser = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
