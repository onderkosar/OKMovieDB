//
//  Constants.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

let genreDict = [["title": "Horror", "id": 27],
                 ["title": "Action", "id": 28],
                 ["title": "Adventure", "id": 12],
                 ["title": "War", "id": 10752],
                 ["title": "Comedy", "id": 35],
                 ["title": "Romance", "id": 10749],
                 ["title": "Fantasy", "id": 14],
                 ["title": "Drama", "id": 18],
                 ["title": "Crime", "id": 80],
                 ["title": "Science Fiction", "id": 878],
                 ["title": "History", "id": 36],
                 ["title": "Western", "id": 37],
                 ["title": "Animation", "id": 16],
]

enum Images {
    static let moviePlaceholder = UIImage(named: "noimagetop")
}

enum SFSymbols {
    static let calendar     = UIImage(systemName: "calendar")
    static let list         = UIImage(systemName: "list.bullet.indent")
    static let search       = UIImage(systemName: "magnifyingglass")
    static let star         = UIImage(systemName: "star")
    static let starFilled   = UIImage(systemName: "star.fill")
}
