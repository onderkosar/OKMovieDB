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
        backgroundColor     = .systemBackground
        accessoryType       = .disclosureIndicator
        
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
        
        let padding: CGFloat        = 10
        let contenHeight: CGFloat   = contentView.frame.height
        let contentWidth: CGFloat   = contentView.frame.width
        
        let imageHeight: CGFloat    = contenHeight+16
        let labelHeight: CGFloat    = (movieTitleLabel.font.pointSize * 2) + 2
        let labelWidth: CGFloat     = contentWidth-(imageHeight+padding)
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            movieImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            movieTitleLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
    }
}
