//
//  MovieSideBtnVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 27.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieSideBtnVC: UIViewController {
    
    let castButton      = OKButton(backgroundColor: .clear, title: "")
    let videosButton    = OKButton(backgroundColor: .clear, title: "")
    
    var cast: [CastResults]!
    var trailers: [TrailerResults]!
    
    init(cast: [CastResults], trailers: [TrailerResults]) {
        super.init(nibName: nil, bundle: nil)
        self.cast       = cast
        self.trailers   = trailers
    }
    
    init(trailers: [TrailerResults]) {
        super.init(nibName: nil, bundle: nil)
        self.trailers = trailers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureElements()
        configureUI()
    }
    
    
    private func configureElements() {
        castButton.setImage(Images.castBtnImg, for: .normal)
        castButton.tintColor = .systemOrange
        
        videosButton.setImage(Images.playBtnImg, for: .normal)
        videosButton.tintColor = .systemOrange
        
        castButton.addTarget(self, action: #selector(castButtonPressed), for: .touchUpInside)
        videosButton.addTarget(self, action: #selector(videosButtonPressed), for: .touchUpInside)
    }
    
    private func configureUI() {
        view.addSubviews(castButton, videosButton)
        
        let padding: CGFloat    = 10
        
        NSLayoutConstraint.activate([
            castButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            castButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            castButton.widthAnchor.constraint(equalToConstant: 40),
            castButton.heightAnchor.constraint(equalToConstant: 40),
            
            videosButton.topAnchor.constraint(equalTo: castButton.bottomAnchor, constant: padding * 2),
            videosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videosButton.widthAnchor.constraint(equalToConstant: 30),
            videosButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc func castButtonPressed() {
        if cast.count == 0 {
            presentOKAlertOnMainThread(title: "N/A", message: "No cast info available for this movie.", buttonTitle: "Ok")
            return
        }
        
        let destVC   = CastListVC()
        destVC.cast  = cast
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    @objc func videosButtonPressed() {
        if trailers.count == 0 {
            presentOKAlertOnMainThread(title: "N/A", message: "No trailer available for this movie.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: trailers[0].trailerURL)
    }
}
