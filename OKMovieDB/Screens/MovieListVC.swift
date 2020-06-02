//
//  MovieListVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieListVC: OKDataLoadingVC {
    
    enum Section { case main }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Results>!
    var collectionView: UICollectionView!

    var genreId: Int!
    
    var movies: [Results]   = []
    var page                = 1
    var hasMoreMovies       = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureDataSource()
        getMovies(for: genreId, page: page)
        
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func getMovies(for genreId: Int, page: Int) {
        showLoadingView()
        
        NetworkManager.shared.getMovies(for: genreId, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case.success(let movies):
                if movies.count < 20 { self.hasMoreMovies = false }
                self.movies.append(contentsOf: movies)
                self.updateData()
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Results>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)

            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Results>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)

        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension MovieListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreMovies else { return }
            page += 1
            getMovies(for: genreId, page: page)
        }
    }
}
