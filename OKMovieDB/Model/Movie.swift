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
    let releaseDate: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var date: String {
        return releaseDate.convertToDisplayFormat()
    }
    
    var ratingStarsVoted: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        
        return "\(ratingText)"
    }
    
    var ratingStarsRemaining: String {
        let remainingStars = 10-Int(voteAverage)
        let remainingStarText = (0..<remainingStars).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return "\(remainingStarText) (\(voteCount) votes)"
    }
    
}
