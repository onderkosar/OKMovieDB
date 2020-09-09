//
//  NetworkManager.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

#warning("Register for an API key at themoviedb.org and place below.")
let apiKey      = Keys.apiKeyMovieDB
let baseURL     = "https://api.themoviedb.org/3/"

class NetworkManager {
    
    static let shared       = NetworkManager()
    let cache               = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func fetch<Model: Decodable>(restURL: String, completed: @escaping (Model) -> ()) {
        let endpoint = baseURL + restURL
        
        guard let url = URL(string: endpoint) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let obj  = try decoder.decode(Model.self, from: data)
                completed(obj)
            } catch let err {
                print(err)
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self ,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
    }
}
