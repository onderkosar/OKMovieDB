//
//  MovieInfoVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 5.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieInfoVC: OKDataLoadingVC {
    
    let scrollView      = UIScrollView()
    let contentView     = UIView()
    
    let headerView      = UIView()
    let overviewView    = UIView()
    let castsView       = UIView()
    
    var itemViews: [UIView] = []
    
    var movieId : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getMovieInfo()
        getCastInfo()
    }
    
    func configureViewController() {
        view.backgroundColor                = .systemBackground
        
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        let favButton                       = UIBarButtonItem(image: SFSymbols.starFilled, style: .done, target: self, action: #selector(addFavorites))
        
        doneButton.tintColor                = .systemOrange
        favButton.tintColor                 = .systemOrange
        
        navigationItem.rightBarButtonItem   = doneButton
        navigationItem.leftBarButtonItem    = favButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1200)
        ])
    }
    
    func layoutUI() {
        let padding: CGFloat    = 10
        
        itemViews = [headerView, overviewView, castsView]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 520),
            
            overviewView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            overviewView.heightAnchor.constraint(equalToConstant: 320),
            
            castsView.topAnchor.constraint(equalTo: overviewView.bottomAnchor, constant: padding),
            castsView.heightAnchor.constraint(equalToConstant: 260),
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func addFavorites() {
        showLoadingView()
        
        NetworkManager.shared.getMovieInfo(for: movieId) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let movie):
                self.addMovieToFavorites(movie: movie)
            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func addMovieToFavorites(movie: Movie) {
        let favorite = Results(title: movie.title, id: movie.id, backdropPath: movie.backdropPath)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentOKAlertOnMainThread(title: "Success!", message: "You have successfully favorited this movie.", buttonTitle: "Ok")
                return
            }
            self.presentOKAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    func getMovieInfo() {
        NetworkManager.shared.getMovieInfo(for: movieId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movie):
                DispatchQueue.main.async { self.configureUIElements(with: movie) }
            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func getCastInfo() {
        NetworkManager.shared.getCastInfo(for: movieId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let casts):
                DispatchQueue.main.async { self.add(childVC: MovieCastVC(cast: casts), to: self.castsView) }
            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with movie: Movie) {
            self.add(childVC: MovieHeaderVC(movie: movie), to: self.headerView)
            self.add(childVC: MovieOverviewVC(movie: movie), to: self.overviewView)
        }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
