//
//  NetworkManager.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 09.02.2025.
//

import Foundation
import Combine

class GithubUserAPIService: UserAPIService {
    
    private let baseUrl = "https://api.github.com"
    
    func getFollowers(for username: String, page: Int) -> AnyPublisher<[Follower], GFError> {
        let endpoint = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: endpoint) else {
            return Fail(error: GFError.badURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Follower].self, decoder: decoder)
            .mapError({ error -> GFError in
                if error is URLError {
                    return .badConnection
                } else if error is DecodingError {
                    return .badDecode
                } else {
                    return .badData
                }
            })
            .eraseToAnyPublisher()
    }
    
    func getUserInfo(for username: String) -> AnyPublisher<User, GFError> {
        let endpoint = baseUrl + "/users/\(username)"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: endpoint) else {
            return Fail(error: GFError.badURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: User.self, decoder: decoder)
            .mapError({ error -> GFError in
                if error is URLError {
                    return .badConnection
                } else if error is DecodingError {
                    return .badDecode
                } else {
                    return .badData
                }
            })
            .eraseToAnyPublisher()
    }
}
