//
//  MovieCastVC.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 18.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class MovieCastVC: UIViewController {
    
    let titleLabel      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let castLabel       = OKBodyLabel(textAlignment: .left)
    
    var casts: [MovieCast]!

    init(cast: [MovieCast]) {
        super.init(nibName: nil, bundle: nil)
        self.casts = cast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureUI()
        configureElements()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius     = 18
        view.backgroundColor        = .secondarySystemBackground
    }
    
    private func configureElements() {
        titleLabel.text             = "Cast"
        titleLabel.numberOfLines    = 1
        
        fillCastLabel()
    }
    
    private func configureUI() {
        view.addSubviews(titleLabel, castLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            castLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            castLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding/4),
            castLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding/4),
            castLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    func fillCastLabel() {
        var numbOfLines = Int()
        var castArray   = [String]()
        
        if casts.isEmpty {
            numbOfLines = 1
            titleLabel.text = "No cast data available!"
            return
        } else if casts.count >= 10 {
            numbOfLines = 10
        } else {
            numbOfLines = casts.count
        }
        
        castLabel.numberOfLines = numbOfLines
        for i in 0...numbOfLines-1 {
            castArray.append("- \(casts[i].name) (\(casts[i].character))")
        }
        let castString = castArray.joined(separator: "\n")
        castLabel.text = castString
        
    }
}
