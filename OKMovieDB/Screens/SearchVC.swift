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
        view.backgroundColor = .systemBackground
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
        
        guard isMovieNameEntered else {
            presentOKAlertOnMainThread(title: "Textfield is empty", message: "Please type to search. We need to know which to look for\n😃", buttonTitle: "Ok")
            return
        }
        
        let searchListVC    = SearchListVC()
        searchListVC.query  = searchTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        searchListVC.page   = 1
        
        navigationController?.pushViewController(searchListVC, animated: true)
    }
    
    func configureSearchTextField() {
        searchTextField.delegate = self
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
