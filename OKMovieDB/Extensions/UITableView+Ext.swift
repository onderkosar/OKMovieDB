//
//  UITableView+Ext.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 8.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

extension UITableView {    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
