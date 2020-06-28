//
//  Cast.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 27.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

struct Cast: Codable, Hashable {
    var cast: [CastResults]
}

struct CastResults: Codable, Hashable {
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
    
    var profilePathURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
    }
}
