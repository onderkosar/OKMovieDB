//
//  OKCategoryView.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKCategoryView: UIView {
    
    let categoryImageView   = UIImageView()
    let categoryTitleLabel  = OKTitleLabel(textAlignment: .center, fontSize: 25)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled                  = true
        
        addSubviews(categoryImageView, categoryTitleLabel)
        
        categoryImageView.clipsToBounds                = true
        categoryImageView.contentMode                  = .scaleAspectFit
        categoryImageView.tintColor                    = .label
        categoryImageView.alpha                        = 0.1
        categoryImageView.layer.borderWidth            = 2
        categoryImageView.layer.cornerRadius           = 16
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: self.topAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            categoryTitleLabel.centerYAnchor.constraint(equalTo: categoryImageView.centerYAnchor),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryImageView.leadingAnchor),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: categoryImageView.trailingAnchor),
            categoryTitleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(image: UIImage, text: String) {
        categoryImageView.image = image
        categoryTitleLabel.text = text
    }
}
