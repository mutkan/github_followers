//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 1.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController{
    
    let callToActionButton = CustomButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configureCallToActionButton()
    }
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
                   callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                   callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                   callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                   callToActionButton.heightAnchor.constraint(equalToConstant: 50)
               ])
    }
    
    @objc func pushFollowersListVC(){
        presentAlertOnMainThread(title: "Test Title", message: "Test Message", buttonTitle: "OK")
    }

}
