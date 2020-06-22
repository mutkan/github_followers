//
//  EmptyStateView.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 21.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class EmptyStateView: UIView{
    let messageLabel = CustomTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
                                     messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
                                     messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)])
        
        NSLayoutConstraint.activate([logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170)])
    }
}
