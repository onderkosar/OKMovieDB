//
//  Movie.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable {
    var results: [Results]
}

struct Results: Codable, Hashable {
    var title: String
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
}
