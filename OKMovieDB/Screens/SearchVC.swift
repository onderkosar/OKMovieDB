//
//  SearchVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 9.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit


class SearchVC: UIViewController {
    
    let searchTextField = OKTextField()
    let searchButton    = OKButton(backgroundColor: .systemGray, title: "Search Movie")
    
    var isMovieNameEntered: Bool { return !searchTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubviews(searchTextField, searchButton)
        
        configureSearchTextField()
        configureSearchButton()
        createDismissKeyboardTapGesture()
        
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushMovieListVC() {
        let movieListVC                 = MovieListVC()
        movieListVC.query               = searchTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        movieListVC.page                = 1
        
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    func configureSearchTextField() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(pushMovieListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMovieListVC()
        
        return true
    }
}
