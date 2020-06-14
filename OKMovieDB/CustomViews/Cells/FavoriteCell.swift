//
//  FavoriteCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 7.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID      = "favoriteCell"
    
    let movieImageView      = OKImageView(content: .scaleAspectFill)
    let movieTitleLabel     = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: Results) {
        movieTitleLabel.text = favorite.title
        if favorite.backdropPath != nil {
            movieImageView.downloadImage(fromURL: favorite.backdropURL)
            
        }
    }
    
    private func configure() {
        addSubviews(movieImageView, movieTitleLabel)
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieImageView.heightAnchor.constraint(equalToConstant: 60),
            movieImageView.widthAnchor.constraint(equalToConstant: 60),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 24),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding*3),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
