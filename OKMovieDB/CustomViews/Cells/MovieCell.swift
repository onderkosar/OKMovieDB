//
//  MovieCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseID      = "movieCell"
    
    let placeholderImage    = SFSymbols.camera
    
    let movieImageView      = OKImageView(content: .scaleAspectFit)
    let movieTitleLabel     = OKTitleLabel(textAlignment: .left, fontSize: 15)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = placeholderImage
    }

    
    func set(movies: Results) {
        movieTitleLabel.text = movies.title
        if movies.backdropPath != nil { movieImageView.downloadImage(fromURL: movies.backdropURL) }
    }
    
    private func configure() {
        addSubviews(movieImageView, movieTitleLabel)
        
        movieImageView.tintColor         = .secondaryLabel
        movieImageView.layer.borderWidth = 2

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: cellHeight),
            movieImageView.heightAnchor.constraint(equalToConstant: cellHeight*9/16),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5),
            movieTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieTitleLabel.widthAnchor.constraint(equalToConstant: cellHeight),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
}
