//
//  MovieCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseID          = "MovieCell"
    
    let moviePosterView         = OKCategoryView()
    let placeholderImage        = SFSymbols.camera
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterView.categoryImageView.image = placeholderImage
    }

    
    func set(movies: Results) {
        moviePosterView.categoryTitleLabel.text = movies.title
        if movies.backdropPath != nil {
            moviePosterView.categoryImageView.downloadImage(fromURL: movies.backdropURL)
        }
    }
    
    private func configure() {
        addSubview(moviePosterView)
        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            moviePosterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            moviePosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            moviePosterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            moviePosterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
