//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 13.08.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views:  UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
