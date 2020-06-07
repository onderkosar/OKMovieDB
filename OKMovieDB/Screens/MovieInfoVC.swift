//
//  MovieInfoVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 5.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieInfoVC: OKDataLoadingVC {
    
    let scrollView = UIScrollView()
    let headerView = UIView()
    
    var movieId : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieInfo()
        configureViewController()
        configureScrollView()
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
                let favorite = Results(title: movie.title, id: movie.id, backdropPath: movie.posterPath)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentOKAlertOnMainThread(title: "Success!", message: "You have successfully favorited this movie.", buttonTitle: "Ok")
                        return
                    }
                    self.presentOKAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    func getMovieInfo() {
        NetworkManager.shared.getMovieInfo(for: movieId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.add(childVC: OKMovieInfoHeaderVC(movie: movie), to: self.headerView)
                }

            case .failure(let error):
                self.presentOKAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureViewController() {
        view.backgroundColor                = .systemBackground
        
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        let favButton                       = UIBarButtonItem(image: SFSymbols.starFilled, style: .done, target: self, action: #selector(addFavorites))
        navigationItem.rightBarButtonItem   = doneButton
        navigationItem.leftBarButtonItem    = favButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        
        scrollView.pinToEdges(of: view)
        headerView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 800)
        ])
    }
        
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
