//
//  OKSecondaryTitleLabel.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 6.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKSecondaryTitleLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        adjustsFontSizeToFitWidth   = true
        textColor                   = .secondaryLabel
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
    }
}
