//
//  Movie.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 6.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable {
    let title: String
    let id: Int
    var releaseDate: String?
    var popularity: Double?
    var overview: String?
    let posterPath: String
    let backdropPath: String
}
