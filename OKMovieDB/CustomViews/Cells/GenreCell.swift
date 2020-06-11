//
//  GenreCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 11.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    static let reuseID = "genreCell"
    
    let movieView = OKMovieCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureMovieCell()
        setMovieCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor = .systemBackground
    }
    
    func configureMovieCell() {
        addSubview(movieView)
        
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            movieView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setMovieCell() {
        let image   = UIImage(named: "history")!
        let text    = "Movie name..."
        
        movieView.set(image: image, text: text)
    }
}
