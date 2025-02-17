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
        
//        guard let url = URL(string: endpoint) else {
//            completion(.failure(.badUsername))
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completion(.failure(.badConnection))
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure(.badRequest))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.badData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                
//                let followers = try decoder.decode([Follower].self, from: data)
//                completion(.success(followers))
//            } catch {
//                completion(.failure(.badDecode))
//            }
//        }
//        task.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseUrl + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.badConnection))
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 404 {
                completion(.failure(.badUsername))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.badDecode))
            }
        }
        task.resume()
    }
}
