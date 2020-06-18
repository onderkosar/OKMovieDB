//
//  MovieHeaderVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 18.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieHeaderVC: UIViewController {
    
    let movieImageView      = OKImageView(content: .scaleAspectFit)
    let movieTitleLabel     = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let dateImageView       = UIImageView()
    let releaseDateLabel    = OKSecondaryTitleLabel(fontSize: 16)
    let voteStarsLabel      = OKSecondaryTitleLabel(fontSize: 14)
    let voteCountLabel      = OKSecondaryTitleLabel(fontSize: 14)
    
    var movie: Movie!

    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureElements()
    }
    
    
    func configureElements() {
        if movie.posterPath != nil { movieImageView.downloadImage(fromURL: movie.posterURL) }
        dateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        movieTitleLabel.text            = movie.title
        movieTitleLabel.numberOfLines   = 2
        
        dateImageView.image             = SFSymbols.calendar
        dateImageView.tintColor         = .secondaryLabel
        
        releaseDateLabel.text           = movie.date
        
        voteStarsLabel.text             = movie.ratingStarsVoted
        voteStarsLabel.tintColor        = .systemGray
        voteStarsLabel.textColor        = .systemYellow
        
        voteCountLabel.text             = movie.ratingStarsRemaining
    }
    
    func configureUI() {
        view.addSubviews(movieImageView, movieTitleLabel, dateImageView, releaseDateLabel, voteStarsLabel, voteCountLabel)
        
        let posterHeight: CGFloat       = view.bounds.width
        let posterWidth:CGFloat         = posterHeight*2/3
        let padding: CGFloat            = 20
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            movieImageView.heightAnchor.constraint(equalToConstant: posterHeight),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: padding),
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 42),
            
            dateImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: padding/2),
            dateImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateImageView.widthAnchor.constraint(equalToConstant: 20),
            dateImageView.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateLabel.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: padding/2),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            voteStarsLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor),
            voteStarsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            voteStarsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            voteCountLabel.centerYAnchor.constraint(equalTo: voteStarsLabel.centerYAnchor),
            voteCountLabel.leadingAnchor.constraint(equalTo: voteStarsLabel.trailingAnchor),
            voteCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            voteCountLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    
}
