//
//  CastCell.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 27.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class CastCell: UITableViewCell {
    static let reuseID      = "castCell"
    let placeholderImage    = Images.moviePlaceholder
    
    let castImageView       = OKImageView(content: .scaleAspectFill)
    let nameLabel           = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let characterLabel      = OKSecondaryTitleLabel(fontSize: 15)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor     = .systemBackground
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           castImageView.image = placeholderImage
    }
    
    
    func set(cast: MovieCast) {
        nameLabel.text          = cast.name
        characterLabel.text     = cast.character
        
        if cast.profilePath != nil { castImageView.downloadImage(fromURL: cast.profilePathURL) }
    }
    
    private func configure() {
        addSubviews(castImageView, nameLabel, characterLabel)
        
        let padding: CGFloat        = 10
        let contentHeight: CGFloat  = contentView.frame.height
        let imageHeight: CGFloat    = contentHeight+16
        
        NSLayoutConstraint.activate([
            castImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            castImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            castImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            castImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            
            nameLabel.centerYAnchor.constraint(equalTo: castImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: castImageView.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: contentHeight/2),
            
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            characterLabel.leadingAnchor.constraint(equalTo: castImageView.trailingAnchor, constant: padding),
            characterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterLabel.heightAnchor.constraint(equalToConstant: contentHeight/2),
        ])
    }

}
