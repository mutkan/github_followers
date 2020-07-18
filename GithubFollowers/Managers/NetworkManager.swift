//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 10.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    typealias completionHandlerForGetFollowers = (Result<[Follower], CustomErr>) -> Void
    
    typealias completionHandlerForGetUserInfo = (Result<User, CustomErr>) -> Void
    
    func getUserInfo(for userName: String, completed: @escaping completionHandlerForGetUserInfo){
        let endpoint = baseUrl + userName
        
        guard let url = URL(string: endpoint) else {
            completed(Result.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(Result.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(Result.success(user))
            }catch{
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getFollowers(for userName: String, page: Int, completed: @escaping completionHandlerForGetFollowers) {
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
