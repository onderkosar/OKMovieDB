//
//  Casts.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 17.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

struct Casts: Codable, Hashable {
    var cast: [MovieCast]
}

struct MovieCast: Codable, Hashable {
    let id: Int
    let character: String
    let name: String
}
