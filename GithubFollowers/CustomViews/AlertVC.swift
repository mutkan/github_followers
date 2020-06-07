//
//  AlertVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 4.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class AlertVC: UIViewController{
    let containerView = UIView()
    let titleLabel = CustomTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = CustomBodyLabel(textAlignment: .center)
    let actionButton = CustomButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle:String?
    var alertMessage:String?
    var buttonTitle:String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertMessage = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        configureTitleLabel()
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        
        containerView.layer.cornerRadius = 22
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.blue.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 299),
            containerView.widthAnchor.constraint(equalToConstant: 200)])
    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)])
        
    }
}
