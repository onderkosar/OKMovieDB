//
//  GenresVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 14.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class GenresVC: UIViewController {
    var genresCollectionView: UICollectionView!
    
    var genreType   = [Genres.horror,
                       Genres.action,
                       Genres.romance,
                       Genres.history,
                       Genres.comedy,
                       Genres.animation,
                       Genres.war,
                       Genres.adventure,
                       Genres.drama
        
    ]
    
    var genreTitle  = ["Horror",
                       "Action",
                       "Romance",
                       "History",
                       "Comedy",
                       "Animation",
                       "War",
                       "Adventure",
                       "Drama"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    
    func configureCollectionView() {
        genresCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        genresCollectionView.register(GenresCell.self, forCellWithReuseIdentifier: GenresCell.reuseID)
        genresCollectionView.translatesAutoresizingMaskIntoConstraints = false
        genresCollectionView.delegate         = self
        genresCollectionView.dataSource       = self
        genresCollectionView.backgroundColor  = .systemBackground
        
        view.addSubview(genresCollectionView)
    }
}

extension GenresVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: cellHeight-20)
    }
}

extension GenresVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCell.reuseID, for: indexPath) as! GenresCell
        cell.collectionTitleLabel.text = genreTitle[indexPath.row] + " Movies"
        cell.getMovies(for: genreType[indexPath.row], page: 1)
        cell.genreId = genreType[indexPath.row]
        return cell
    }
}
