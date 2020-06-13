//
//  Follower.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 10.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
