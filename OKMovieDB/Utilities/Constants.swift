//
//  Constants.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

let cellHeight: CGFloat = 170

enum SFSymbols {
    static let star         = UIImage(systemName: "star")
    static let starFilled   = UIImage(systemName: "star.fill")
    
    static let trash        = UIImage(systemName: "trash")
    static let trashFilled  = UIImage(systemName: "trash.fill")
    
    static let search       = UIImage(systemName: "magnifyingglass")
    static let eyeglasses   = UIImage(systemName: "eyeglasses")
    
    static let camera       = UIImage(systemName: "video")
    static let camerFilled  = UIImage(systemName: "video.fill")
    
    static let calendar     = UIImage(systemName: "calendar")
}

enum Genres {
    static let horror: Int          = 27
    static let romance: Int         = 10749
    static let action: Int          = 28
    static let animation: Int       = 16
    static let comedy: Int          = 35
    static let history: Int         = 36
    
    static let adventure: Int       = 12
    static let fantasy: Int         = 14
    static let drama: Int           = 18
    static let western: Int         = 37
    static let thriller: Int        = 53
    static let crime: Int           = 80
    static let documentary: Int     = 99
    static let scienceFiction: Int  = 878
    static let mystery: Int         = 9648
    static let music: Int           = 10402
    static let family: Int          = 10751
    static let war: Int             = 10752
    static let tvMovie: Int         = 10770
}
