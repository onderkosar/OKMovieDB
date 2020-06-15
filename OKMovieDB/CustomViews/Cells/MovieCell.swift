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
    
    let placeholderImage    = Images.moviePlaceholder
    
    let movieImageView      = OKImageView(content: .scaleAspectFit)
    let movieTitleLabel     = OKTitleLabel(textAlignment: .center, fontSize: 20)
    
    
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
        
        movieTitleLabel.backgroundColor     = UIColor.black.withAlphaComponent(0.5)
        movieTitleLabel.textColor           = .white
        movieTitleLabel.clipsToBounds       = true
        movieTitleLabel.layer.cornerRadius  = 10
        movieTitleLabel.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        let padding:CGFloat                 = 5
        let imageHeight: CGFloat            = contentView.frame.height-padding*3
        let imageWidh: CGFloat              = imageHeight*16/9
        let labelHeight: CGFloat            = movieTitleLabel.font.pointSize + 5

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: imageWidh),
            movieImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            movieTitleLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor)
        ])
    }
}
