//
//  CustomizeButton.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 4.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class CustomButton: UIButton{
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
