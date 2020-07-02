
//
//  CustomTextField.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 7.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class CustomTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .blue
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .yes
        returnKeyType = .go
        placeholder = "Enter a username"
    }
}
