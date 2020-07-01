//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 30.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else {
            return "N/A"
        }
        
        return date.convertToMonthYearFormat()
    }
    
    //    date is optional because we can't always guarantee it's the exact format.
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
}
