//
//  CategoriesVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {
    
    let horrorView      = OKCategoryView()
    let comedyView      = OKCategoryView()
    let romanceView     = OKCategoryView()
    let actionView      = OKCategoryView()
    let historyView     = OKCategoryView()
    let animationView   = OKCategoryView()
    
    var allViews: [OKCategoryView]  = []
    var allString: [String]         = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCategoryView()
        configureActionButtons()
    }
    
    
    @objc func horrorTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC     = MovieListVC()
        movieListVC.genreId = Genres.horror
        movieListVC.title   = "Horror List"
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @objc func comedyTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC     = MovieListVC()
        movieListVC.genreId = Genres.comedy
        movieListVC.title   = "Comedy List"
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @objc func romanceTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC     = MovieListVC()
        movieListVC.genreId = Genres.romance
        movieListVC.title   = "Romance List"
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @objc func actionTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC     = MovieListVC()
        movieListVC.genreId = Genres.action
        movieListVC.title   = "Action List"
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @objc func historyTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC     = MovieListVC()
        movieListVC.genreId = Genres.history
        movieListVC.title   = "History List"
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @objc func animationTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC     = MovieListVC()
        movieListVC.genreId = Genres.animation
        movieListVC.title   = "Animation List"
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    func configureCategoryView() {
        allViews = [horrorView, comedyView, romanceView, actionView, historyView, animationView]
        
        horrorView.set(image: GenreImages.horror, text: "Horror")
        comedyView.set(image: GenreImages.comedy, text: "Comedy")
        romanceView.set(image: GenreImages.romance, text: "Romance")
        actionView.set(image: GenreImages.action, text: "Action")
        historyView.set(image: GenreImages.history, text: "History")
        animationView.set(image: GenreImages.animation, text: "Animation")
        
        for item in allViews {
            view.addSubview(item)
            NSLayoutConstraint.activate([
                item.heightAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view)*4/5),
                item.widthAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view))
            ])
        }
        
        NSLayoutConstraint.activate([
            
            horrorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            horrorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            comedyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            comedyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            romanceView.topAnchor.constraint(equalTo: horrorView.bottomAnchor, constant: 10),
            romanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            actionView.topAnchor.constraint(equalTo: comedyView.bottomAnchor, constant: 10),
            actionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            historyView.topAnchor.constraint(equalTo: romanceView.bottomAnchor, constant: 10),
            historyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            animationView.topAnchor.constraint(equalTo: actionView.bottomAnchor, constant: 10),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    func configureActionButtons() {
        let horrorTapGesture: UITapGestureRecognizer    = UITapGestureRecognizer(target: self, action: #selector(horrorTapping(recognizer:)))
        let comedyTapGesture: UITapGestureRecognizer    = UITapGestureRecognizer(target: self, action: #selector(comedyTapping(recognizer:)))
        let romanceTapGesture: UITapGestureRecognizer   = UITapGestureRecognizer(target: self, action: #selector(romanceTapping(recognizer:)))
        let actionTapGesture: UITapGestureRecognizer    = UITapGestureRecognizer(target: self, action: #selector(actionTapping(recognizer:)))
        let historyTapGesture: UITapGestureRecognizer   = UITapGestureRecognizer(target: self, action: #selector(historyTapping(recognizer:)))
        let animationTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animationTapping(recognizer:)))
        
        horrorView.addGestureRecognizer(horrorTapGesture)
        comedyView.addGestureRecognizer(comedyTapGesture)
        romanceView.addGestureRecognizer(romanceTapGesture)
        actionView.addGestureRecognizer(actionTapGesture)
        historyView.addGestureRecognizer(historyTapGesture)
        animationView.addGestureRecognizer(animationTapGesture)
    }
}
