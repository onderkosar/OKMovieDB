//
//  OKMovieInfoHeaderVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 6.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKMovieInfoHeaderVC: UIViewController {

    let posterImageView     = OKPosterImageView(frame: .zero)
    let movieTitleLabel     = OKTitleLabel(textAlignment: .left, fontSize: 30)
    let dateImageView       = UIImageView()
    let releaseDateLabel    = OKSecondaryTitleLabel(fontSize: 20)
    let voteStarsLabel      = OKSecondaryTitleLabel(fontSize: 14)
    let voteCountLabel      = OKSecondaryTitleLabel(fontSize: 14)
    let overviewLabel       = OKBodyLabel(textAlignment: .justified)
    
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
        view.addSubviews(posterImageView, movieTitleLabel, dateImageView, releaseDateLabel, voteStarsLabel, voteCountLabel, overviewLabel)
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements() {
        if movie.posterPath != nil {
         posterImageView.downloadImage(fromURL: movie.posterURL)
        }
        
        movieTitleLabel.text        = movie.title
        
        dateImageView.image         = SFSymbols.calendar
        dateImageView.tintColor     = .secondaryLabel
        
        releaseDateLabel.text       = movie.date
        
        voteStarsLabel.text         = movie.ratingStarsVoted
        voteStarsLabel.tintColor    = .systemGray
        voteStarsLabel.textColor    = .systemYellow

        voteCountLabel.text         = movie.ratingStarsRemaining
        
        overviewLabel.text          = movie.overview
    }
    
    func layoutUI() {
        dateImageView.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = 10
        
        let posterHeight: CGFloat       = view.bounds.width
        let posterWidth:CGFloat         = posterHeight*2/3
        let padding: CGFloat            = 20
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: posterHeight),
            
            movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding),
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            dateImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: padding/2),
            dateImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateImageView.widthAnchor.constraint(equalToConstant: 20),
            dateImageView.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateLabel.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: padding/2),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 25),
            
            voteStarsLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: padding),
            voteStarsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            voteStarsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            voteCountLabel.centerYAnchor.constraint(equalTo: voteStarsLabel.centerYAnchor),
            voteCountLabel.leadingAnchor.constraint(equalTo: voteStarsLabel.trailingAnchor),
            voteCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            voteCountLabel.heightAnchor.constraint(equalToConstant: 15),
            
            overviewLabel.topAnchor.constraint(equalTo: voteCountLabel.bottomAnchor, constant: padding),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}
