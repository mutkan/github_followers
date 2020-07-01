//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 30.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
