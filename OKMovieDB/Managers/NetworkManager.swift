//
//  NetworkManager.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared       = NetworkManager()
    let cache               = NSCache<NSString, UIImage>()
    
    #warning("Register for an API key at themoviedb.org and place below.")
    private let apiKey      = Keys.apiKeyMovieDB
    private let baseURL     = "https://api.themoviedb.org/3/"
    
    private init() {}
    
    var movies  = [Results]()
    var cast    = [CastResults]()
    
    func getMovies(for genreId: Int, page:Int, completed: @escaping (Result<[Results], OKError>) -> Void) {
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
                let movies  = try decoder.decode(Movies.self, from: data)
                self.movies = movies.results
                completed(.success(self.movies))

            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getMovieInfo(for movieId: Int, completed: @escaping (Result<Movie, OKError>) -> Void) {
        let endpoint = baseURL + "movie/\(movieId)?api_key=\(apiKey)&language=en-US"


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
                let movie   = try decoder.decode(Movie.self, from: data)
                completed(.success(movie))

            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
    func getCastInfo(for movieId: Int, completed: @escaping (Result<[CastResults], OKError>) -> Void) {
        let endpoint = baseURL + "movie/\(movieId)/credits?api_key=\(apiKey)"


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
                let cast    = try decoder.decode(Cast.self, from: data)
                self.cast   = cast.cast
                completed(.success(self.cast))

            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
    func getMovieTrailers(for movieId: Int, completed: @escaping (Result<[TrailerResults], OKError>) -> Void) {
        let endpoint = baseURL + "movie/\(movieId)/videos?api_key=\(apiKey)&language=en-US"
        
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
                let trailer   = try decoder.decode(Trailers.self, from: data)
                completed(.success(trailer.results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        // Önceden indirilmiş fotoğrafları scroll yaptığımızda yeniden yüklememek için cache içerisinde tutmalıyız...
        let cacheKey = NSString(string: urlString)
        
        // Fotoğraf cache içerisinde varsa yükleme kısmına geçmiyoruz...
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        // Fotoğraf cache içerisinde yoksa yüklüyoruz...
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            // Handling errors first.
            guard let self = self ,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            // Yüklenen fotoğrafı yeniden yüklememek için cache içerisine alıyoruz
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
            
        }
        
        task.resume()
    }
    
    func searchMovie(for query: String, page:Int, completed: @escaping (Result<[Results], OKError>) -> Void) {
        let endpoint = baseURL + "search/movie?api_key=\(apiKey)&language=en-US&query=\(query)&page=1&include_adult=false"
        
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
                let movies = try decoder.decode(Movies.self, from: data)
                self.movies = movies.results
                completed(.success(self.movies))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
