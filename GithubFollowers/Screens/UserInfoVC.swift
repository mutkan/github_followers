//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 21.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController{
    
    var userName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
        
        
        NetworkManager.shared.getUserInfo(for: userName){
            [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
