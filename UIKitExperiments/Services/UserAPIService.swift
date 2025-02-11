//
//  UserAPIService.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 10.02.2025.
//

protocol UserAPIService {
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void)
    func getFollowersCount(for username: String, completion: @escaping (Result<Int, GFError>) -> Void)
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void)
}
