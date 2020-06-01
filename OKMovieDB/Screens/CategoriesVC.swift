//
//  CategoriesVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {
    
    let horrorView = OKCategoryView()
    let comedyView = OKCategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCategoryView()
        configureActionButtons()
    }
    
    
    @objc func horrorTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC = MovieListVC()
        movieListVC.getMovies(for: Genres.horror)
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @objc func comedyTapping(recognizer: UITapGestureRecognizer) {
        let movieListVC = MovieListVC()
        movieListVC.getMovies(for: Genres.comedy)
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    func configureCategoryView() {
        view.addSubviews(horrorView,comedyView)
        horrorView.set(image: SFSymbols.star!, text: "Horror")
        comedyView.set(image: SFSymbols.star!, text: "Comedy")
        
        NSLayoutConstraint.activate([
            horrorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            horrorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horrorView.heightAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view)),
            horrorView.widthAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view)),
            
            comedyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            comedyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            comedyView.heightAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view)),
            comedyView.widthAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view))
        ])
    }
    
    func configureActionButtons() {
        let horrorTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(horrorTapping(recognizer:)))
        let comedyTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(comedyTapping(recognizer:)))
        horrorView.addGestureRecognizer(horrorTapGesture)
        comedyView.addGestureRecognizer(comedyTapGesture)
    }
}
