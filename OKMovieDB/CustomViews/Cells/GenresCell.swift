//
//  GenresCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 14.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class GenresCell: UICollectionViewCell {
    static let reuseID = "genresCell"
    
    var moviesCollectionView: UICollectionView!
    
    let collectionTitleLabel = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    enum Section { case main }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Results>!
    
    var movies: [Results]           = []
    var filteredMovies: [Results]   = []
    
    var genreId: Int! {
        didSet { if movies.count == 0 { getMovies(for: genreId, page: 1) } }
    }
    
    var page                        = 1
    var hasMoreMovies               = true
    var isSearching                 = false
    var isLoadingMoreMovies         = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureElements()
        configureCollectionView()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureElements() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        moviesCollectionView.backgroundColor    = .systemBackground
        moviesCollectionView.delegate           = self
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        
        collectionTitleLabel.text =  "Movie genre"
    }
    
    private func configureCollectionView() {
        
        addSubviews(collectionTitleLabel, moviesCollectionView)
        
        NSLayoutConstraint.activate([
            collectionTitleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            collectionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            collectionTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            moviesCollectionView.topAnchor.constraint(equalTo: collectionTitleLabel.bottomAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            moviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            moviesCollectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func getMovies(for genreId: Int, page: Int) {
        isLoadingMoreMovies = true
        
        NetworkManager.shared.getMovies(for: genreId, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let movies):
                self.updateUI(with: movies)
            case.failure(let error):
                print(error)
            }
            self.isLoadingMoreMovies = false
        }
    }
    
    func updateUI(with movies: [Results]) {
        if movies.count < 20 { self.hasMoreMovies = false }
        self.movies.append(contentsOf: movies)
        
        if self.movies.isEmpty {
            let message = "There is no movie in this search."
            print(message)
            return
        }
        
        self.updateData(on: self.movies)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Results>(collectionView: moviesCollectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
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

extension GenresCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = frame.height*4/3
        let cellHeight: CGFloat = frame.height
        return CGSize(width: cellWidth, height: cellHeight - 25)
    }
}

extension GenresCell: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX        = scrollView.contentOffset.x
        let contentWidth   = scrollView.contentSize.width
        let width          = scrollView.frame.size.width
        
        if offsetX > contentWidth - width {
            guard hasMoreMovies, !isLoadingMoreMovies else { return }
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
        self.window?.rootViewController?.present(navController, animated: true)
    }
}
