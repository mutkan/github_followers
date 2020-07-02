//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 2.07.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

enum PersistenceActionType{
    case add, remove
}

enum PersistenceManager{
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], CustomErr>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else{
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorites))
        }
    }
    
    static func save(favorites: [Follower]) -> CustomErr?{
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        }
        catch{
            return .unableToFavorites
        }
        return nil
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (CustomErr?) -> Void){
        retrieveFavorites{ result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType{
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll{ $0.login == favorite.login }
                    
                    completed(save(favorites: retrievedFavorites))
                }
            case .failure(let error):
                completed(error)
            }
        }
    }
}
