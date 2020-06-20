//
//  CustomBodyLabel.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 4.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class CustomBodyLabel: UILabel{
    init(textAlignment: NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
