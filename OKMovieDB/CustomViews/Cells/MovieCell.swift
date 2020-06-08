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
    let imageBaseUrl: String    = "https://image.tmdb.org/t/p/w500"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        moviePosterView.categoryImageView.image = SFSymbols.camera
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func set(movies: Results) {
        
        NetworkManager.shared.downloadImage(from: imageBaseUrl + movies.backdropPath) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.moviePosterView.categoryImageView.image = image }
        }
        
        moviePosterView.categoryTitleLabel.text = movies.title
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
