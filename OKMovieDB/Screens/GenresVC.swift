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
        return CGSize(width: view.frame.width, height: view.frame.width/2.5)
    }
}

extension GenresVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCell.reuseID, for: indexPath) as! GenresCell
        cell.collectionTitleLabel.text = genreDict[indexPath.row]["title"] as! String + " Movies"
        cell.genreId = (genreDict[indexPath.row]["id"] as! Int)
        return cell
    }
}
