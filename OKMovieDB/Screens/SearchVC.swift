//
//  SearchVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 9.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit


class SearchVC: UIViewController {
    
    let searchTextField     = OKTextField()
    let searchButton        = OKButton(backgroundColor: .systemGray, title: "Search Movie")
    
    let padding: CGFloat    = 50
    
    var isMovieNameEntered: Bool { return !searchTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureSearchTextField()
        configureSearchButton()
        createDismissKeyboardTapGesture()
        
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func searchButtonPressed() {
        
        guard isMovieNameEntered else {
            presentOKAlertOnMainThread(title: "Textfield is empty", message: "Please type to search. We need to know which to look for\n😃", buttonTitle: "Ok")
            return
        }
        
        let destVC    = SearchListVC()
        destVC.query  = searchTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        destVC.page   = 1
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func configureSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.delegate = self
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            searchTextField.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            searchButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonPressed()
        
        return true
    }
}
