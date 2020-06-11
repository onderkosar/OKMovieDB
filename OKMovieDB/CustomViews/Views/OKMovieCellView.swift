//
//  OKMovieCellView.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 11.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKMovieCellView: UIView {
    
    let cellImageView   = OKPosterImageView(frame: .zero)
    let cellTitleLabel  = OKTitleLabel(textAlignment: .center, fontSize: 14)
    
    
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
        
        addSubviews(cellImageView, cellTitleLabel)

        cellImageView.tintColor         = .secondaryLabel
        cellImageView.alpha             = 0.8
        cellImageView.layer.borderWidth = 2
        
        cellTitleLabel.numberOfLines = 2
        
        let imgWidth: CGFloat = 170
        let imgHeight: CGFloat = imgWidth*9/16

        NSLayoutConstraint.activate([
            
            cellImageView.topAnchor.constraint(equalTo: self.topAnchor),
            cellImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: imgWidth),
            cellImageView.heightAnchor.constraint(equalToConstant: imgHeight),
            
            cellTitleLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 5),
            cellTitleLabel.leadingAnchor.constraint(equalTo: cellImageView.leadingAnchor),
            cellTitleLabel.trailingAnchor.constraint(equalTo: cellImageView.trailingAnchor),
            cellTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func set(image: UIImage, text: String) {
        cellImageView.image = image
        cellTitleLabel.text = text
    }
}
