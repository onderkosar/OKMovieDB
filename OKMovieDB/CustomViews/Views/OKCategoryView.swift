//
//  OKCategoryView.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKCategoryView: UIView {
    
    let categoryImageView   = OKPosterImageView(frame: .zero)
    let categoryTitleLabel  = OKTitleLabel(textAlignment: .center, fontSize: 15)
    
    
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

        categoryImageView.tintColor         = .secondaryLabel
        categoryImageView.alpha             = 0.8
        categoryImageView.layer.borderWidth = 2
        
        let imgWidth: CGFloat = 150
        let imgHeight: CGFloat = imgWidth*9/16

        NSLayoutConstraint.activate([
            
            categoryImageView.topAnchor.constraint(equalTo: self.topAnchor),
            categoryImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: imgWidth),
            categoryImageView.heightAnchor.constraint(equalToConstant: imgHeight),
            
            categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 5),
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
