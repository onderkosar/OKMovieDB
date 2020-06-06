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
    
    var movies: [Results]           = []
    var filteredMovies: [Results]   = []
    
    var page                        = 1
    var hasMoreMovies               = true
    var isSearching                 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
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
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate         = self
        searchController.searchResultsUpdater       = self
        searchController.searchBar.placeholder      = "Search for a movie"
        navigationItem.searchController             = searchController
        navigationItem.hidesSearchBarWhenScrolling  = false
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
                
                if self.movies.isEmpty {
                    let message = "There is no movie left in this category, that was the last page."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                
                self.updateData(on: self.movies)
            case.failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Results>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movies: movie)

            return cell
        })
    }
    
    func updateData(on movies: [Results]) {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredMovies : movies
        let movies          = activeArray[indexPath.item]
        
        let destVC          = MovieInfoVC()
        destVC.movieId      = movies.id
        
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension MovieListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredMovies = movies.filter { $0.title.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredMovies)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: movies)
    }
    
}
