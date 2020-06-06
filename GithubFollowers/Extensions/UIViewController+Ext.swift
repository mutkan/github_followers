//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 5.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, buttonTitle:  buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
