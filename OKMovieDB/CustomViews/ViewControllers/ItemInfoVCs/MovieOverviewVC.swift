//
//  MovieOverviewVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 18.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieOverviewVC: UIViewController {
    
    let titleLabel      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let overviewLabel   = OKBodyLabel(textAlignment: .justified)
    
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
        configureBackgroundView()
        configureUI()
        configureElements()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius     = 18
        view.backgroundColor        = .secondarySystemBackground
    }
    
    
    private func configureElements() {
        titleLabel.text             = "Overview"
        titleLabel.numberOfLines    = 1
        
        overviewLabel.numberOfLines = 12
        overviewLabel.text          = movie.overview
    }
    
    private func configureUI() {
        view.addSubviews(titleLabel, overviewLabel)
        
        let padding: CGFloat        = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding/2),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding/2)
        ])
    }
}
