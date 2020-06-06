//
//  MovieInfoVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 5.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit



class MovieInfoVC: UIViewController {
    
    let headerView = UIView()
    
    var movieId : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getMovieInfo()
        layoutUI()
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func addFavorites() {
        print("Function is not ready yet!")
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
        view.backgroundColor                = .systemBlue
        
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        let favButton                       = UIBarButtonItem(image: SFSymbols.starFilled, style: .done, target: self, action: #selector(addFavorites))
        navigationItem.rightBarButtonItem   = doneButton
        navigationItem.leftBarButtonItem    = favButton
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo:view.trailingAnchor)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
