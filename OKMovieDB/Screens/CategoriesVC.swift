//
//  CategoriesVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

let horrorView = OKCategoryView()

class CategoriesVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        configureCategoryView()
        configureActionButtons()
        
    }
    
    
    @objc func viewTapping(recognizer: UITapGestureRecognizer) {
        print("UIView is tapped")
    }
    
    func configureCategoryView() {
        view.addSubview(horrorView)
        horrorView.set(image: SFSymbols.star!, text: "Horror")
        
        NSLayoutConstraint.activate([
            horrorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            horrorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horrorView.heightAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view)),
            horrorView.widthAnchor.constraint(equalToConstant: UIHelper.twoColumnWidht(in: view))
        ])
    }
    
    func configureActionButtons() {
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapping(recognizer:)))
        horrorView.addGestureRecognizer(viewTapGesture)
    }
}
