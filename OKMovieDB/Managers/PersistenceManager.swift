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
    enum Key { static let favorites = "favorites" }
    
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
    
    static func updateWith(favorite: Results, actionType: PersistenceActionType, completed: @escaping (OKError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case.success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(where: {$0.id == favorite.id}) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case.remove:
                    favorites.removeAll { $0.id == favorite.id }
                }
                
                completed(save(favorites: favorites))
                
            case.failure(let error):
                completed(error)
            }
        }
    }
}
