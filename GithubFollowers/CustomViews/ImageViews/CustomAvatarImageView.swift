//
//  CustomAvatarImageView.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 11.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

class CustomAvatarImageView: UIImageView{
    let placeHolder = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        layer.cornerRadius = 10
        image = placeHolder
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String){
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url){ [weak self](data, response, error) in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            
            guard let imageData = UIImage(data: data) else {return}
            self.cache.setObject(imageData, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = imageData
            }
        }
        task.resume()
        
    }
}
