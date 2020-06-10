//
//  Movies.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 5.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

struct Movies: Codable, Hashable {
    var results: [Results]
}

struct Results: Codable, Hashable {
    let title: String
    let id: Int
    let backdropPath: String?
}
