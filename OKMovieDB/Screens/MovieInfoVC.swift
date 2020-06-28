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
    let buttonsView     = UIView()

    var movieId         = Int()
    var overviewHeight  = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getMovieInfo()
        getCastInfo()
        getMovieTrailers()
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
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 500)
        ])
    }
    
    func layoutUI() {
        contentView.addSubviews(headerView, overviewView, buttonsView)
        let padding: CGFloat    = 10
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 520),
            
            overviewView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            overviewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            overviewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            overviewView.heightAnchor.constraint(greaterThanOrEqualToConstant: overviewHeight),
            
            buttonsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            buttonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            buttonsView.widthAnchor.constraint(equalToConstant: 30),
            buttonsView.heightAnchor.constraint(equalToConstant: 90),
        ])
       
    }
    
    func modifyViewsHeight() {
        let headerviewHeight: CGFloat       = headerView.bounds.height
        let overviewTotalHeight: CGFloat    = overviewHeight + 82
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: headerviewHeight + overviewTotalHeight),
            overviewView.heightAnchor.constraint(equalToConstant: overviewTotalHeight),
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
                DispatchQueue.main.async {
                    self.overviewHeight = UIHelper.labelHeight(text: movie.overview, font: UIFont.preferredFont(forTextStyle: .body), width: self.overviewView.frame.width-20)
                    self.modifyViewsHeight()
                    self.configureUIElements(with: movie)
                }
            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func getMovieTrailers() {
        NetworkManager.shared.getMovieTrailers(for: movieId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let trailers):
                DispatchQueue.main.async { self.add(childVC: MovieSideBtnVC(trailers: trailers), to: self.buttonsView) }
            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func getCastInfo() {
        NetworkManager.shared.getCastInfo(for: movieId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let cast):
                DispatchQueue.main.async { self.add(childVC: MovieSideBtnVC(cast: cast), to: self.buttonsView) }
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
