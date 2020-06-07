//
//  PersistenceManager.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 6.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Key {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Results, actionType: PersistenceActionType, completed: @escaping (OKError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case.success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                    
                case.remove:
                    retrievedFavorites.removeAll { $0.id == favorite.id }
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case.failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Results], OKError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Key.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder     = JSONDecoder()
            let favorites   = try decoder.decode([Results].self, from: favoritesData)
            completed(.success(favorites))

        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Results]) -> OKError? {
        do {
            let encoder             = JSONEncoder()
            let encodedFavorites    = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Key.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
        
    }
}
