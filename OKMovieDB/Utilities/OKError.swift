//
//  OKError.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

enum OKError: String, Error {
    case invalidURL             = "Please check your URL"
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case unableToFavorite       = "There was an error favoriting this movie. Please try again."
    case alreadyInFavorites     = "You've already favorited this movie. You must REALLY like it!"
}
