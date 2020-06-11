//
//  CollectionMainCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 11.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class CollectionMainCell: UICollectionViewCell {
    static let reuseID = "collectionMainCell"
    
    var moviesCollectionView: UICollectionView!
    let collectionNameLabel = OKTitleLabel(textAlignment: .left, fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMoviesCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMoviesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        moviesCollectionView.backgroundColor = .systemBackground
        moviesCollectionView.delegate   = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.reuseID)
        
        collectionNameLabel.text =  "Movie genre"
        addSubview(collectionNameLabel)
        addSubview(moviesCollectionView)
        
        
        NSLayoutConstraint.activate([
            collectionNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            collectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            collectionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            moviesCollectionView.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CollectionMainCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = frame.height*4/3
        let cellHeight: CGFloat = frame.height
        return CGSize(width: cellWidth, height: cellHeight - 25)
    }
}

extension CollectionMainCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.reuseID, for: indexPath)
        return cell
    }
    
    
}

