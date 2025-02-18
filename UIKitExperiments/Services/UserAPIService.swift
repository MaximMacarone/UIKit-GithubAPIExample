//
//  UserAPIService.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 10.02.2025.
//

import Combine

protocol UserAPIService {
    func getFollowers(for username: String, page: Int) -> AnyPublisher<[Follower], GFError>
//    func getFollowersCount(for username: String) -> AnyPublisher<Int, GFError>
    func getUserInfo(for username: String) -> AnyPublisher<User, GFError>
}
