//
//  MovieCollectionVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 11.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieCollectionVC: UIViewController {
    
    var collectionView: UICollectionView!

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

extension MovieCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
}

extension MovieCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionMainCell.reuseID, for: indexPath) as! CollectionMainCell
        
        return cell
    }
    
}
