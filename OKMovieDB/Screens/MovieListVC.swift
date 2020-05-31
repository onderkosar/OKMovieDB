//
//  MovieListVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        getMovies(for: Genres.horror)
        
    }
    
    
    func getMovies(for genreId: Int) {
        NetworkManager.shared.getMovies(for: genreId, page: 1) { result in
            switch result {
            case.success(let movies):
                self.movies = [movies]
                
                for i in 0...9 {
                    print("\(i+1)-\(movies.results[i].title)")
                }
                
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }
}
