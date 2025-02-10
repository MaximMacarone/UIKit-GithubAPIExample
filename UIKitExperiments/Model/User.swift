//
//  User.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 09.02.2025.
//

struct User: Codable {
    let login: String
    let avatarUrl: String
    let createdAt: String
    let name: String?
    let location: String?
    let bio: String?
    
    let htmlUrl: String
    
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    
    
    let reposUrl: String
    let gistsUrl: String
    let followersUrl: String
}
