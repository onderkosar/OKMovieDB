//
//  UIHelper.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

enum UIHelper {
    static func twoColumnWidht(in view: UIView) -> CGFloat {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing)
        let itemWidht                   = availableWidth / 2
        
        return itemWidht
    }
}
