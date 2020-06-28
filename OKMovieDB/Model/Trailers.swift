//
//  Trailers.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 28.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

struct Trailers: Codable, Hashable {
    var results: [TrailerResults]
}

struct TrailerResults: Codable, Hashable {
    let name: String
    let key: String
    
    var trailerURL: URL {
        return URL(string: "https://www.youtube.com/watch?v=\(key)")!
    }
}
