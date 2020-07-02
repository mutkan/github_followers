//
//  ErrorMessages.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 10.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

enum CustomErr: String, Error{
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again"
    case unableToFavorites = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user.You must REALLY like them!"
}
