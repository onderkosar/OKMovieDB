//
//  OKTextField.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 9.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 9
        returnKeyType               = .go
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        clearButtonMode             = .whileEditing
        placeholder                 = "Enter a movie name"
    }
}
