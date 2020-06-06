//
//  OKMovieInfoHeaderVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 6.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKMovieInfoHeaderVC: UIViewController {
    
    let imageBaseUrl        = "https://image.tmdb.org/t/p/w500"

    let posterImageView     = OKPosterImageView(frame: .zero)
    let movieTitleLabel     = OKTitleLabel(textAlignment: .left, fontSize: 30)
    let dateImageView       = UIImageView()
    let releaseDateLabel    = OKSecondaryTitleLabel(fontSize: 20)
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
        addUIElements()
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements() {
        posterImageView.downloadImage(fromURL: imageBaseUrl + movie.posterPath)
        movieTitleLabel.text    = movie.title
        releaseDateLabel.text   = movie.releaseDate.convertToDisplayFormat()
        
        dateImageView.image     = SFSymbols.calendar
        dateImageView.tintColor = .secondaryLabel
        
        overviewLabel.text      = movie.overview
    }
    
    func addUIElements() {
        view.addSubviews(posterImageView, movieTitleLabel, dateImageView, releaseDateLabel, overviewLabel)
    }
    
    func layoutUI() {
        dateImageView.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = 10
        
        let posterHeight: CGFloat       = view.bounds.width
        let posterWidth:CGFloat         = posterHeight*2/3
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: posterHeight),
            
            movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding),
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            dateImageView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: textImagePadding),
            dateImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateImageView.widthAnchor.constraint(equalToConstant: 20),
            dateImageView.heightAnchor.constraint(equalToConstant: 20),
            
            releaseDateLabel.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: textImagePadding/2),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 25),
            
            overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: padding),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}
