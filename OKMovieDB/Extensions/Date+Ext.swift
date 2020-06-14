//
//  Date+Ext.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 6.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }
}
