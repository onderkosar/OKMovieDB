//
//  MovieCastVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 18.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieCastVC: OKDataLoadingVC {
    
    let castsButton     = OKButton(backgroundColor: .systemGray3, title: "Casts")
    let videosButton    = OKButton(backgroundColor: .systemGray3, title: "Trailers")
    
    var casts: [MovieCast]!

    init(cast: [MovieCast]) {
        super.init(nibName: nil, bundle: nil)
        self.casts = cast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureElements()
        configureBackgroundView()
        configureUI()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius     = 18
        view.backgroundColor        = .secondarySystemBackground
    }
    
    private func configureElements() {
        castsButton.addTarget(self, action: #selector(castsButtonPressed), for: .touchUpInside)
        videosButton.addTarget(self, action: #selector(videosButtonPressed), for: .touchUpInside)
    }
    
    private func configureUI() {
        view.addSubviews(castsButton, videosButton)
        
        let padding: CGFloat = 10
        let itemWidth: CGFloat = (view.bounds.width / 2) - (padding * 2.5)
        
        NSLayoutConstraint.activate([
            castsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            castsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            castsButton.widthAnchor.constraint(equalToConstant: itemWidth),
            castsButton.heightAnchor.constraint(equalToConstant: 30),
            
            videosButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            videosButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            videosButton.widthAnchor.constraint(equalToConstant: itemWidth),
            videosButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    @objc func castsButtonPressed() {
        if casts.count == 0 {
            presentOKAlertOnMainThread(title: "N/A", message: "No cast info available for this movie.", buttonTitle: "Ok")
            return
        }
        
        let castsTableVC    = CastListVC()
        castsTableVC.casts  = casts
        
        navigationController?.pushViewController(castsTableVC, animated: true)
    }
    
    @objc func videosButtonPressed() {
        print("Trailers")
    }
}
