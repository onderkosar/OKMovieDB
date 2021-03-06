//
//  OKImageView.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 14.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKImageView: UIImageView {
    
    let placeholderImage    = Images.moviePlaceholder
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(content: ContentMode) {
        self.init(frame: .zero)
        contentMode = content
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        tintColor           = .secondaryLabel
    }
    
    func downloadImage(fromURL url: URL) {
        NetworkManager.shared.downloadImage(from: "\(url)") { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}
