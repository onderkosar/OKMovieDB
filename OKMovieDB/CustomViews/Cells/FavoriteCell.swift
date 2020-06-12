//
//  FavoriteCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 7.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID          = "FavoriteCell"
    
    let moviePosterImageView    = OKPosterImageView(frame: .zero)
    let movieTitleLabel         = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    
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
            moviePosterImageView.downloadImage(fromURL: favorite.backdropURL)
        }
    }
    
    private func configure() {
        addSubviews(moviePosterImageView, movieTitleLabel)
        moviePosterImageView.contentMode = .scaleAspectFill
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            moviePosterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 60),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: 60),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 24),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
