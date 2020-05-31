//
//  NetworkManager.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared       = NetworkManager()
    
    private let baseURL     = "https://api.themoviedb.org/3/"
    private let apiKey      = Keys.apiKeyMovieDB
    
    private init() {}
    
    
    func getMovies(for genreId: Int, page:Int, completed: @escaping (Result<Movie, OKError>) -> Void) {
        let endpoint = baseURL + "discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&page=\(page)&with_genres=\(genreId)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(Movie.self, from: data)
                completed(.success(movies))

            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
}
