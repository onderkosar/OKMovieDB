//
//  SearchListVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 14.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class SearchListVC: OKDataLoadingVC {
    enum Section { case main }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Results>!
    var collectionView: UICollectionView!
    
    var genreId: Int!
    var query: String!
    
    var movies: [Results]           = []
    var filteredMovies: [Results]   = []
    
    var page                        = 1
    var hasMoreMovies               = true
    var isSearching                 = false
    var isLoadingMoreMovies         = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        configureDataSource()
        searchMovies(for: query, page: page)
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayoutFor(columns: 2, in: view))
        view.addSubview(collectionView)
        collectionView.delegate         = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater       = self
        searchController.searchBar.placeholder      = "Type to collapse search."
        navigationItem.searchController             = searchController
        navigationItem.hidesSearchBarWhenScrolling  = false
    }
    
    func searchMovies(for query: String, page: Int) {
        let urlStr = "search/movie?api_key=\(apiKey)&language=en-US&query=\(query)&page=1&include_adult=false"
        
        showLoadingView()
        isLoadingMoreMovies = true
        
        NetworkManager.shared.fetch(restURL: urlStr) { [weak self] (movies: Movies) in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            self.updateUI(with: movies.results)
            self.isLoadingMoreMovies = false
        }
    }
    
    func updateUI(with movies: [Results]) {
        if movies.count < 20 { self.hasMoreMovies = false }
        self.movies.append(contentsOf: movies)
        
        if self.movies.isEmpty {
            let message = "There is no movie in this search."
            DispatchQueue.main.async { self.presentOKAlertOnMainThread(title: "No movie!", message: message, buttonTitle: "Ok") }
            return
        } else {
            DispatchQueue.main.async {
                self.configureSearchController()
            }
        }
        
        self.updateData(on: self.movies)
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

extension SearchListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreMovies, !isLoadingMoreMovies else { return }
            page += 1
            
            searchMovies(for: query, page: page)
        }
    }
    
    func collectionView(_  collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredMovies : movies
        let movies          = activeArray[indexPath.item]
        
        let destVC          = MovieInfoVC()
        destVC.movieId      = movies.id
        
        let navController   = UINavigationController(rootViewController: destVC)
        self.present(navController, animated: true)
    }
}

extension SearchListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredMovies = movies.filter { $0.title.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredMovies)
    }
}
