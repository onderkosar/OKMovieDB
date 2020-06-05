//
//  MovieInfoVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 5.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit



class MovieInfoVC: UIViewController {
    
    var moviename: String!
    var movieid: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        getMovieInfo()
        
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    
    func getMovieInfo() {
        NetworkManager.shared.getMovieInfo(for: movieid) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                print("Movie Title Is: \(movie.title)")
            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}
