//
//  CollectionVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 12.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    var collectionView: UICollectionView!
    
    var genreType   = [Genres.horror, Genres.action, Genres.romance, Genres.history, Genres.comedy, Genres.animation]
    var genreTitle  = ["Horror", "Action", "Romance", "History", "Comedy", "Animation"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CollectionMainCell.self, forCellWithReuseIdentifier: CollectionMainCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate         = self
        collectionView.dataSource       = self
        collectionView.backgroundColor  = .systemBackground
        
        view.addSubview(collectionView)
    }
}

extension CollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionMainCell.reuseID, for: indexPath) as! CollectionMainCell
        cell.collectionNameLabel.text = genreTitle[indexPath.row] + " Movies"
        cell.getMovies(for: genreType[indexPath.row], page: 1)
        cell.genreId = genreType[indexPath.row]
        return cell
    }
    
}
