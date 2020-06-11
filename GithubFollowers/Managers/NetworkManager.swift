//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 10.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    typealias completionHandler = (Result<[Follower], CustomErr>) -> Void
    
    func getFollowers(for userName: String, page: Int, completed: @escaping completionHandler) {
        let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else{
            completed(Result.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ (data, response,error) in
            if let _ = error{
                completed(Result.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(Result.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(Result.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(Result.success(followers))
            }catch{
                completed(Result.failure(.invalidData))
            }
        }
        task.resume()
    }
}
