//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 2.07.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

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
}
