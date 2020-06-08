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
    let userTextField = CustomTextField()
    let logoImageView = UIImageView()
    
    var isUsernameEntered: Bool {!(userTextField.text!.isEmpty)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCallToActionButton()
        configureLogoImageView()
        configureTextField()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureTextField(){
        view.addSubview(userTextField)
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userTextField.heightAnchor.constraint(equalToConstant: 48)])
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        
        logoImageView.image = UIImage(named: "gh-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)])
    }
    
    @objc func pushFollowersListVC(){
        guard isUsernameEntered else{
            presentAlertOnMainThread(title: "Test Title", message: "Test Message", buttonTitle: "OK")
            return
        }
        
    }
    
}
