//
//  OKPosterImageView.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 5.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKPosterImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeholderImage    = SFSymbols.camera
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        contentMode         = .scaleAspectFit
        tintColor           = .secondaryLabel
    }
    
}
